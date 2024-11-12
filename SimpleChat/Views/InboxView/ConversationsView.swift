//
//  ConversationsView.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

struct ConversationsView: View {
    private let inboxService: InboxService = InboxService()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(inboxService.conversations) { conversation in
                NavigationLink(value: conversation) {
                    ConversationRow(conversation: conversation)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Inbox")
            .navigationDestination(for: Conversation.self) { conversation in
                ChatView(messageService: MessageService(conversation: conversation, chatService: inboxService.chatService), messages: conversation.messages.sorted(using: KeyPathComparator(\.lastUpdated)))
                    .navigationTitle(conversation.name)
            }
            .animation(.easeInOut, value: inboxService.conversations)
        }
        .task {
            await inboxService.loadConversations()
        }
    }
}

#Preview {
    ConversationsView()
}
