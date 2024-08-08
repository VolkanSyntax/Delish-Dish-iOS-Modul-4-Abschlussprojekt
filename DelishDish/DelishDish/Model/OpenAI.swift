//
//  OpenAI.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation

// Yeni eklenen yapılar
struct ChatCompletionRequest: Encodable {
    let model: String
    let messages: [ChatMessage]
}

struct ChatMessage: Codable { // Codable, hem Encodable hem de Decodable protokollerine uygundur
    let role: String
    let content: String
}

struct ChatCompletionResponse: Decodable {
    struct Choice: Decodable {
        let message: ChatMessage
    }
    
    let choices: [Choice]
}

