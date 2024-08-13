//
//  RecipesAIViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//


import Foundation
import Combine

class RecipesAIViewModel: ObservableObject {
    
    @Published var chats: [Chat] = []
    @Published var isLoading: Bool = false
    @Published var message: String = ""
    
    private let repository = RecipesOpenAIRepository()
    
    private let keywords = [
        "yemek", "tarifi", "hazırlanır", "hazirlanir","yapılışı","yapilisi", // Türkçe
        "recipe", "food", "meal", // İngilizce
        "Essen", "Rezept", "Lebensmittelrezept", "Nahrungsmittelrezept",
        "Kochrezept" // Almanca
    ]
    
    @MainActor
    func sendMessage() {
        guard !message.isEmpty else { return }
        
        isLoading = true
        let chat = Chat(id: UUID().uuidString, content: message, createAt: Date(), sender: .me)
        chats.append(chat)
        message = ""
        
        Task {
            if isMessageAboutRecipes(chat.content) {
                do {
                    let responseText = try await repository.sendMessage(prompt: chat.content)
                    let responseChat = Chat(id: UUID().uuidString, content: responseText, createAt: Date(), sender: .chatGPT)
                    chats.append(responseChat)
                } catch {
                    print("Failed to send message: \(error)")
                }
            } else {
                let errorMessage = "I can only provide information about Recipes.\nIch kann nur Informationen über Rezepte bereitstellen."
                let errorChat = Chat(id: UUID().uuidString, content: errorMessage, createAt: Date(), sender: .chatGPT)
                chats.append(errorChat)
            }
            
            isLoading = false
        }
    }
    
    private func isMessageAboutRecipes(_ message: String) -> Bool {
        for keyword in keywords {
            if message.localizedCaseInsensitiveContains(keyword) {
                return true
            }
        }
        return false
    }
}




