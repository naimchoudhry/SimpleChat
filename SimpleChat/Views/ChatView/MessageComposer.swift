//
//  MessageComposer.swift
//  SimpleChat
//
//  Created by Naim Choudhry on 11/11/2024.
//

import SwiftUI

struct MessageComposer: View {
    var sendAction: (String) -> Void
    @State private var message: String = ""
    @FocusState var keyboardActive: Bool
    
    var body: some View {
        HStack {
            TextField("Write a message", text: $message, axis: .vertical)
                .lineLimit(5)
                .padding(.horizontal)
                .padding(.vertical, 6)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray).opacity(0.5)
                }
                .focused($keyboardActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            keyboardActive = false
                        }
                    }
                }
            Button(action: {
                sendAction(message.trimmingCharacters(in: .whitespacesAndNewlines))
                keyboardActive = false
                message = ""
            }, label: {
                Image(systemName: "arrow.up")
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .disabled(message.isEmpty)
        }
        .padding()
        .padding(.trailing, -8)
        .background(Color.white)
    }
}

#Preview {
    Color.clear
        .safeAreaInset(edge: .bottom) {
            MessageComposer { _ in }
        }
}
