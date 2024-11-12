//
//  ChatView.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

struct ChatView: View {
    @State var messageService: MessageService
    @State var messages: [Message] = []
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(messages) { message in
                        ChatRow(message: message)
                            .id(message.id)
                            .padding()
                    }
                    EmptyView()
                        .id("bottom")
                }
            }
            .onChange(of: messages) {
                proxy.scrollTo("bottom")
            }
        }
        .defaultScrollAnchor(.bottom)
        .animation(.easeInOut, value: messages)
        .safeAreaInset(edge: .bottom) {
            MessageComposer(sendAction: send(_:))
        }
        .task {
            await messagesListener()
        }
        .onDisappear {
            messageService.updateConversation()
        }
    }
}

private extension ChatView {
    func messagesListener() async {
        for await message in messageService.messages {
            messages.append(message)
        }
    }
    
    func send(_ message: String) {
        Task {
            await messageService.send(message: Message(type: .sent, id: UUID().uuidString, text: message, lastUpdated: .now))
        }
    }
}

#Preview {
    ChatView(messageService: MessageService(conversation: Conversation(id: "1", name: "Test", lastUpdated: .now, messages: []), chatService: ChatService()))
}
