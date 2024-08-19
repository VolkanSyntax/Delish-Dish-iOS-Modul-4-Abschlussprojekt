//
//  RecipesAIViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//


import Foundation
import Combine
import NaturalLanguage

class RecipesAIViewModel: ObservableObject { // Erstellt eine ViewModel-Klasse, die Daten speichert und verwaltet. / Bir ViewModel sınıfı oluşturur, bu sınıf verileri tutar ve yönetir.
    
    @Published var chats: [Chat] = [] // Hält eine Liste der Chat-Nachrichten. / Sohbet mesajlarının listesini tutar.
    @Published var isLoading: Bool = false // Gibt an, ob eine Nachricht gesendet oder empfangen wird. / Bir mesajın gönderilip gönderilmediğini veya alınıp alınmadığını belirtir.
    @Published var message: String = "" // Der aktuelle Nachrichteninhalt, den der Benutzer eingibt. / Kullanıcının girdiği mevcut mesaj içeriği.
    
    private let repository = RecipesOpenAIRepository() // Eine Instanz des Repositories, das die Nachrichten verarbeitet. / Mesajları işleyen bir repository örneği.
    
    @MainActor // Gibt an, dass diese Funktion im Hauptthread ausgeführt wird. / Bu işlevin ana iş parçacığında çalıştığını belirtir.
    func sendMessage() {
        guard !message.isEmpty else { return } // Sendet die Nachricht nur, wenn sie nicht leer ist, andernfalls wird der Vorgang abgebrochen. / Mesaj boş değilse mesajı gönderir, boşsa işlemi sonlandırır.
        
        isLoading = true // Startet den Ladezustand und gibt an, dass eine Nachricht gesendet wird. / Yükleme durumunu başlatır ve bir mesajın gönderildiğini belirtir.
        let chat = Chat(id: UUID().uuidString, content: message, createAt: Date(), sender: .me) // Erstellt eine neue Chat-Nachricht. / Yeni bir sohbet mesajı oluşturur.
        chats.append(chat) // Fügt die Nachricht zur Liste der Chats hinzu. / Mesajı sohbet listesine ekler.
        message = "" // Leert das Nachrichtenfeld nach dem Senden. / Gönderdikten sonra mesaj alanını temizler.
        
        Task { // Startet asynchrone Operationen. / Asenkron işlemleri başlatır.
            defer {
                isLoading = false // Beendet den Ladezustand, wird ausgeführt, wenn die Operation abgeschlossen ist oder ein Fehler auftritt. / Yükleme durumunu sonlandırır, işlem tamamlandığında veya hata oluştuğunda çalışır.
            }
            
            let isRelated = await isRelatedToCooking(chat.content) // Überprüft, ob die Nachricht sich auf Kochen bezieht. / Mesajın yemekle ilgili olup olmadığını kontrol eder.
            
            if isRelated { // Wenn die Nachricht sich auf das Kochen bezieht. / Eğer mesaj yemekle ilgiliyse.
                do {
                    let responseText = try await repository.sendMessage(prompt: chat.content) // Sendet die Nachricht an das Repository und wartet auf eine Antwort. / Mesajı repository'ye gönderir ve yanıt bekler.
                    let responseChat = Chat(id: UUID().uuidString, content: responseText, createAt: Date(), sender: .chatGPT) // Erstellt eine neue ChatGPT-Antwort. / Yeni bir ChatGPT yanıtı oluşturur.
                    chats.append(responseChat) // Fügt die Antwort zur Liste der Chats hinzu. / Yanıtı sohbet listesine ekler.
                } catch {
                    print("Failed to send message: \(error)") // Gibt eine Fehlermeldung aus, falls das Senden fehlschlägt. / Gönderme başarısız olursa hata mesajı yazdırır.
                }
            } else { // Wenn die Nachricht sich nicht auf das Kochen bezieht. / Eğer mesaj yemekle ilgili değilse.
                let languageCode = Locale.current.language.languageCode?.identifier ?? "en" // Ruft den Sprachcode des Geräts ab, falls dies fehlschlägt, wird Englisch standardmäßig angenommen. / Cihazın dil kodunu alır, eğer başarısız olursa İngilizceyi varsayar.
                let errorMessage = localizedErrorMessage(for: languageCode) // Ruft die Fehlermeldung basierend auf dem Sprachcode ab. / Dil koduna göre hata mesajını alır.
                let errorChat = Chat(id: UUID().uuidString, content: errorMessage, createAt: Date(), sender: .chatGPT) // Erstellt eine neue Fehlermeldung. / Yeni bir hata mesajı oluşturur.
                chats.append(errorChat) // Fügt die Fehlermeldung zur Liste der Chats hinzu. / Hata mesajını sohbet listesine ekler.
            }
        }
    }
    
    private func isRelatedToCooking(_ message: String) async -> Bool { // Bestimmt, ob die Nachricht sich auf das Kochen bezieht. / Mesajın yemekle ilgili olup olmadığını belirler.
        do {
            let classificationPrompt = "Is the following message related to cooking? Please answer with 'yes' or 'no': \(message)" // Text, der fragt, ob die Nachricht sich auf das Kochen bezieht. / Mesajın yemekle ilgili olup olmadığını soran metin.
            let classificationResponse = try await repository.sendMessage(prompt: classificationPrompt) // Sendet die Nachricht an das Repository und wartet auf eine Antwort. / Mesajı repository'ye gönderir ve yanıt bekler.
            let isCookingRelated = classificationResponse.lowercased().contains("yes") // Überprüft, ob die Antwort "yes" enthält. / Yanıtın "yes" içerip içermediğini kontrol eder.
            return isCookingRelated // Gibt true zurück, wenn die Antwort "yes" ist. / Yanıt "yes" ise true döner.
        } catch {
            print("Failed to classify message: \(error)") // Gibt eine Fehlermeldung aus, falls die Klassifizierung der Nachricht fehlschlägt. / Yanıtı sınıflandırma başarısız olursa hata mesajı yazdırır.
            return false // Gibt false zurück im Fehlerfall. / Hata durumunda false döner.
        }
    }
    
    
    private func localizedErrorMessage(for languageCode: String) -> String { // Gibt die passende Fehlermeldung basierend auf dem Sprachcode zurück. / Dil koduna göre uygun hata mesajını döner.
        switch languageCode {
        case "tr": // Wenn der Sprachcode Türkisch ist. / Eğer dil kodu Türkçe ise.
            return "Bu soru yemek üzerine değil, sadece yemekle ilgili sorulara yanıt verebilirim." // Türkische Fehlermeldung. / Türkçe hata mesajı.
        case "de": // Wenn der Sprachcode Deutsch ist. / Eğer dil kodu Almanca ise.
            return "Diese Frage bezieht sich nicht auf das Kochen. Ich kann nur Fragen im Zusammenhang mit Rezepten beantworten." // Deutsche Fehlermeldung. / Almanca hata mesajı.
        default: // Wenn der Sprachcode Englisch oder eine andere Sprache ist. / Eğer dil kodu İngilizce ise veya diğer dillerde ise.
            return "This question is not related to cooking. I can only answer questions related to recipes." // Englische Fehlermeldung. / İngilizce hata mesajı.
        }
    }
}







