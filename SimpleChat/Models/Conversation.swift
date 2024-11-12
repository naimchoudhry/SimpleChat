//
//  Conversation.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import Foundation

struct Conversation: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    var lastUpdated: Date
    var messages: [Message]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastUpdated = "last_updated"
        case messages
    }
}
