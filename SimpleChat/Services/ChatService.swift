//
//  ChatService.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import Foundation

/// API Service to load initial chats with message history to date
actor ChatService {
    private var conversations: [Conversation] = []
    @MainActor var conversationsUpdated: (([Conversation]) -> Void)?
    
    func updateConversationMessages(_ conversation: Conversation, withMessages messages: [Message]) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index].messages.append(contentsOf: messages)
            conversations[index].lastUpdated = messages.last?.lastUpdated ?? .now
            Task { @MainActor in
                await conversationsUpdated?(conversations)
            }
        }
    }
    
    func loadInitialConversations() -> [Conversation] {
        if let url = Bundle.main.url(forResource: "ConversationsPreview", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(formatter)
                self.conversations = try decoder.decode([Conversation].self, from: data)
                return conversations
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
