//
//  Message.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import Foundation

struct Message: Identifiable, Hashable, Codable {
    
    enum MessageType {
        case sent, received
    }
    
    /// Note type is not in original payload, but some indication of wether the message was sent or received needs to be present.
    var type: MessageType = .received
    let id: String
    let text: String
    let lastUpdated: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case lastUpdated = "last_updated"
    }
}
