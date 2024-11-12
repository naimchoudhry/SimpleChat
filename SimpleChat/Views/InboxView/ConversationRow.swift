//
//  ConversationRow.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

struct ConversationRow: View {
    let conversation: Conversation
    var body: some View {
        VStack {
            HStack {
                Text(conversation.name)
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(conversation.lastUpdated.formatRelativeString())
                .font(.subheadline)
                .foregroundStyle(.secondary)
                Spacer()
            }
        }
    }
}

#Preview {
    ConversationRow(conversation: Conversation(id: "1", name: "Test", lastUpdated: Date(), messages: []))
}
