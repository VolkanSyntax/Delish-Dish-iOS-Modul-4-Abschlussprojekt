//
//  RecipesAIViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//


import Foundation
import Combine

class RecipesAIViewModel: ObservableObject {
    
    @Published var chats: [Chat] = [] // Eine Liste der Chat-Nachrichten. / Sohbet mesajlarının listesi.
    @Published var isLoading: Bool = false // Gibt an, ob eine Nachricht gesendet oder empfangen wird. / Bir mesajın gönderilip gönderilmediğini veya alınıp alınmadığını belirtir.
    @Published var message: String = "" // Der aktuelle Nachrichteninhalt, den der Benutzer eingibt. / Kullanıcının girdiği mevcut mesaj içeriği.
    
    private let repository = RecipesOpenAIRepository() // Eine Instanz des Repositories, das die Nachrichten verarbeitet. / Mesajları işleyen bir repository örneği.
    
    private let keywords = [ // Schlüsselwörter, um zu bestimmen, ob die Nachricht sich auf Rezepte bezieht. / Mesajın tariflerle ilgili olup olmadığını belirlemek için anahtar kelimeler.
        "yemek", "tarifi", "hazırlanır", "hazirlanir","yapılışı","yapilisi", // Türkçe / Türkisch
        "recipe", "food", "meal", // İngilizce / Englisch
        "Essen", "Rezept", "Lebensmittelrezept", "Nahrungsmittelrezept",
        "Kochrezept" // Almanca / Deutsch
    ]
    
    @MainActor
    func sendMessage() { // Diese Methode sendet eine Nachricht und verarbeitet die Antwort. / Bu yöntem bir mesaj gönderir ve yanıtı işler.
        guard !message.isEmpty else { return } // Sendet die Nachricht nur, wenn sie nicht leer ist. / Mesaj boş değilse mesajı gönderir.
        
        isLoading = true // Setzt den Ladezustand auf wahr, um anzuzeigen, dass eine Nachricht gesendet wird. / Bir mesaj gönderildiğini belirtmek için yüklenme durumunu doğru olarak ayarlar.
        let chat = Chat(id: UUID().uuidString, content: message, createAt: Date(), sender: .me) // Erstellt eine neue Chat-Nachricht. / Yeni bir sohbet mesajı oluşturur.
        chats.append(chat) // Fügt die Nachricht zur Liste der Chats hinzu. / Mesajı sohbet listesine ekler.
        message = "" // Leert das Nachrichtenfeld nach dem Senden. / Gönderdikten sonra mesaj alanını temizler.
        
        Task {
            if isMessageAboutRecipes(chat.content) { // Prüft, ob die Nachricht sich auf Rezepte bezieht. / Mesajın tariflerle ilgili olup olmadığını kontrol eder.
                do {
                    let responseText = try await repository.sendMessage(prompt: chat.content) // Sendet die Nachricht an das Repository und wartet auf eine Antwort. / Mesajı repository'ye gönderir ve yanıt bekler.
                    let responseChat = Chat(id: UUID().uuidString, content: responseText, createAt: Date(), sender: .chatGPT) // Erstellt eine neue ChatGPT-Antwort. / Yeni bir ChatGPT yanıtı oluşturur.
                    chats.append(responseChat) // Fügt die Antwort zur Liste der Chats hinzu. / Yanıtı sohbet listesine ekler.
                } catch {
                    print("Failed to send message: \(error)") // Gibt eine Fehlermeldung aus, falls das Senden fehlschlägt. / Gönderme başarısız olursa hata mesajı yazdırır.
                }
            } else {
                let errorMessage = "I can only provide information about Recipes." // Eine Fehlermeldung, wenn die Nachricht sich nicht auf Rezepte bezieht. / Mesaj tariflerle ilgili değilse, bir hata mesajı.
                let errorChat = Chat(id: UUID().uuidString, content: errorMessage, createAt: Date(), sender: .chatGPT) // Erstellt eine neue Fehlermeldung von ChatGPT. / ChatGPT'den yeni bir hata mesajı oluşturur.
                chats.append(errorChat) // Fügt die Fehlermeldung zur Liste der Chats hinzu. / Hata mesajını sohbet listesine ekler.
            }
            
            isLoading = false // Setzt den Ladezustand auf falsch, nachdem die Antwort verarbeitet wurde. / Yanıt işlendiğinde yüklenme durumunu yanlış olarak ayarlar.
        }
    }
    
    private func isMessageAboutRecipes(_ message: String) -> Bool { // Überprüft, ob die Nachricht eines der Schlüsselwörter enthält. / Mesajın anahtar kelimelerden birini içerip içermediğini kontrol eder.
        for keyword in keywords { // Durchläuft die Liste der Schlüsselwörter. / Anahtar kelimeler listesini döngüyle geçirir.
            if message.localizedCaseInsensitiveContains(keyword) { // Prüft, ob die Nachricht das Schlüsselwort enthält, unabhängig von der Groß- und Kleinschreibung. / Mesajın, büyük/küçük harfe duyarlı olmaksızın anahtar kelimeyi içerip içermediğini kontrol eder.
                return true // Gibt true zurück, wenn ein Schlüsselwort gefunden wird. / Bir anahtar kelime bulunduğunda doğru değerini döndürür.
            }
        }
        return false // Gibt false zurück, wenn kein Schlüsselwort gefunden wird. / Anahtar kelime bulunmazsa yanlış değerini döndürür.
    }
}




