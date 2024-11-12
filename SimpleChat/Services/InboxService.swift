//
//  InboxService.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

/// Handle Inbox chats list
/// TODO: Add WebSocket code to start listeneing for conversation updates
@Observable @MainActor class InboxService {
    var conversations: [Conversation] = []
    var chatService: ChatService
    
    init() {
        self.chatService = ChatService()
        chatService.conversationsUpdated = { [weak self] conversations in
            self?.updateConversations(conversations)
        }
    }

    func loadConversations() async {
        await updateConversations(chatService.loadInitialConversations())
    }
    
    func updateConversations(_ conversations: [Conversation]) {
        self.conversations = conversations.sorted(using: KeyPathComparator(\.lastUpdated, order: .reverse))
    }
}
