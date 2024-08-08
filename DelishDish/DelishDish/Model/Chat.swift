//
//  Chat.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation


struct Chat {
    let id: String
    let content: String
    let createAt: Date
    let sender: Sender
}

enum Sender {
    case me
    case chatGPT
}

// Sample Data
extension Chat {
    static let sampleChat: [Chat] = [
        Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me),
        Chat(id: UUID().uuidString, content: "Sample message from chatGPT", createAt: Date(), sender: .chatGPT),
        Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me),
        Chat(id: UUID().uuidString, content: "Sample message from chatGPT", createAt: Date(), sender: .chatGPT),
    ]
}

