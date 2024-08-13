//
//  MessageView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import SwiftUI

struct MessageView: View {
    
    let chat: Chat
    
    var body: some View {
        HStack {
            if chat.sender == .me { Spacer() }
            Text(chat.content)
                .foregroundColor(chat.sender == .me ? .white : nil)
                .padding()
                .background(chat.sender == .me ? Color.blue : Color.gray.opacity(0.4))
                .cornerRadius(25)
            if chat.sender == .chatGPT { Spacer() }
            
        }
    }
    
    static var progressView: some View {
        HStack {
            ProgressView()
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(15)
            Spacer()
        }
    }
}

struct MessageBar: View {
    @Binding var message: String
    var sendMessageAction: () -> Void

    var body: some View {
        HStack {
            TextField("Enter a message", text: $message, onCommit: {
                sendMessage()
            })
                .padding(12)
                .background(Color(UIColor.systemGray6))
                .autocorrectionDisabled(true)
                .cornerRadius(20)
                .overlay(
                    HStack {
                        Spacer()
                        if !message.isEmpty {
                            Button(action: {
                                message = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                )
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
                    .padding(.horizontal, 5)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }

    private func sendMessage() {
        if !message.isEmpty {
            sendMessageAction()
            DispatchQueue.main.async {
                self.message = "" // Mesaj gönderildikten sonra TextField içeriğini temizle
            }
        }
    }
}


#Preview {
    VStack {
        MessageView(chat: Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me))
        Spacer()
        MessageBar(message: .constant(""), sendMessageAction: {})
    }
}


