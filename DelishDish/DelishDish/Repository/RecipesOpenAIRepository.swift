//
//  RecipesOpenAIRepository.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation

class RecipesOpenAIRepository {
    enum ApiError: Error {
        case invalidUrl
        case serverError(Int)
        case decodingError
    }
    
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(prompt: String) async throws -> String {
        guard let url = URL(string: baseURL) else {
            throw ApiError.invalidUrl
        }
        
        let messages = [
            ChatMessage(role: "user", content: prompt)
        ]
        
        let openBody = ChatCompletionRequest(model: "gpt-4o", messages: messages)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(ApiKeys.OpenAIAPIKey.rawValue)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(openBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidUrl
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ApiError.serverError(httpResponse.statusCode)
        }
        
        do {
            let response = try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
            guard let text = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {
                throw ApiError.decodingError
            }
            return text
        } catch {
            throw ApiError.decodingError
        }
    }
}
