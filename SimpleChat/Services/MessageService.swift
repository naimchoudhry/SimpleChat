//
//  MessageService.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import Foundation

/// Handle interactive chat session
/// TODO: Add WebSocket code to listen for new messages
@Observable @MainActor class MessageService {
    private var conversation: Conversation
    private var chatService: ChatService
    private var newMessages: [Message] = []
    
    let messages: AsyncStream<Message>
    private let continuation: AsyncStream<Message>.Continuation
    
    init(conversation: Conversation, chatService: ChatService) {
        self.conversation = conversation
        self.chatService = chatService
        (self.messages, self.continuation) = AsyncStream.makeStream(of: Message.self)
    }
    
    /// Send message via URLSessionWebSocketTask, TODO:
    /// - Parameter message: Message Structure containing message details
    func send(message: Message) async {
        newMessages.append(message)
        self.continuation.yield(message)
    }
    
    func updateConversation() {
        if !newMessages.isEmpty {
            Task {
                await chatService.updateConversationMessages(conversation, withMessages: newMessages)
            }
        }
        
    }
}
