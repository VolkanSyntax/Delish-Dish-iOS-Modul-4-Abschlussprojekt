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
        HStack{
            if chat.sender == .me {Spacer()}
            Text(chat.content)
                .foregroundColor(chat.sender == .me ? .white : nil)
                .padding()
                .background(chat.sender == .me ?
                                Color.blue :
                                Color.gray.opacity(0.4))
                .cornerRadius(25)
            if chat.sender == .chatGPT {Spacer()}
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

#Preview {
    MessageView(chat: Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me))
}
