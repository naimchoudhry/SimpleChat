//
//  ChatRow.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

struct ChatRow: View {
    let message: Message

    var body: some View {
        VStack {
            Text(message.lastUpdated.formatRelativeString())
                .font(.footnote)
                .foregroundStyle(.secondary)
            Text(message.text)
                .foregroundStyle(textColor)
                .padding()
                .background {
                    backgroundColor
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .frame(maxWidth: .infinity, alignment: alignment)
        }
    }

    var backgroundColor: Color {
        switch message.type {
            case .sent: .blue
            case .received: .gray.opacity(0.2)
        }
    }

    var textColor: Color {
        switch message.type {
            case .sent: .white
            case .received: .black
        }
    }

    var alignment: Alignment {
        switch message.type {
            case .sent: .trailing
            case .received: .leading
        }
    }
}

#Preview {
    ChatRow(message: Message(id: "1", text: "test", lastUpdated: .now))
}
