//
//  RecipesOpenAIRepository.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation

class RecipesOpenAIRepository {
    
    enum ApiError: Error { // Definiert mögliche Fehler, die bei der API-Kommunikation auftreten können. / API iletişimi sırasında oluşabilecek olası hataları tanımlar.
        case invalidUrl // Fehler, wenn die URL ungültig ist. / URL geçersiz olduğunda hata.
        case serverError(Int) // Fehler, wenn der Server eine Fehlermeldung zurückgibt. / Sunucu bir hata mesajı döndürdüğünde hata.
        case decodingError // Fehler, wenn die Daten nicht richtig dekodiert werden können. / Veriler doğru şekilde çözülemediğinde hata.
    }
    
    private let baseURL = "https://api.openai.com/v1/chat/completions" // Die Basis-URL für die OpenAI-API. / OpenAI API'si için temel URL.
    
    func sendMessage(prompt: String) async throws -> String { // Diese Funktion sendet eine Nachricht an die OpenAI-API und gibt die Antwort zurück. / Bu fonksiyon OpenAI API'sine bir mesaj gönderir ve yanıtı döndürür.
        guard let url = URL(string: baseURL) else { // Überprüft, ob die URL gültig ist. / URL'nin geçerli olup olmadığını kontrol eder.
            throw ApiError.invalidUrl // Wirft einen Fehler, wenn die URL ungültig ist. / URL geçersizse bir hata fırlatır.
        }
        
        let messages = [
            ChatMessage(role: "user", content: prompt) // Erstellt eine Nachricht mit der Rolle "user" und dem übergebenen Text. / "user" rolü ve verilen metinle bir mesaj oluşturur.
        ]
        
        let openBody = ChatCompletionRequest(model: "gpt-4o", messages: messages) // Erstellt den Körper der Anfrage, der an die API gesendet wird. / API'ye gönderilecek isteğin gövdesini oluşturur.
        
        var request = URLRequest(url: url) // Erstellt eine URL-Anfrage. / Bir URL isteği oluşturur.
        request.setValue("application/json", forHTTPHeaderField: "Accept") // Setzt den Accept-Header auf "application/json". / "application/json" kabul başlığını ayarlar.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Setzt den Content-Type-Header auf "application/json". / "application/json" içerik türü başlığını ayarlar.
        request.setValue("Bearer \(ApiKeys.OpenAIAPIKey.rawValue)", forHTTPHeaderField: "Authorization") // Fügt den Autorisierungs-Header hinzu. / Yetkilendirme başlığını ekler.
        request.httpMethod = "POST" // Setzt die HTTP-Methode auf POST. / HTTP metodunu POST olarak ayarlar.
        request.httpBody = try JSONEncoder().encode(openBody) // Kodiert den Anfragekörper als JSON. / İstek gövdesini JSON olarak kodlar.
        
        let (data, response) = try await URLSession.shared.data(for: request) // Führt die Anfrage aus und erhält die Antwortdaten. / İsteği yürütür ve yanıt verilerini alır.
        
        guard let httpResponse = response as? HTTPURLResponse else { // Überprüft, ob die Antwort eine gültige HTTP-Antwort ist. / Yanıtın geçerli bir HTTP yanıtı olup olmadığını kontrol eder.
            throw ApiError.invalidUrl // Wirft einen Fehler, wenn die Antwort ungültig ist. / Yanıt geçersizse bir hata fırlatır.
        }
        
        guard httpResponse.statusCode == 200 else { // Überprüft, ob der Statuscode 200 (OK) ist. / Durum kodunun 200 (OK) olup olmadığını kontrol eder.
            throw ApiError.serverError(httpResponse.statusCode) // Wirft einen Fehler, wenn der Server eine Fehlermeldung zurückgibt. / Sunucu bir hata mesajı döndürürse bir hata fırlatır.
        }
        
        do {
            let response = try JSONDecoder().decode(ChatCompletionResponse.self, from: data) // Dekodiert die Antwortdaten aus dem JSON-Format. / Yanıt verilerini JSON formatından çözer.
            guard let text = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {
                throw ApiError.decodingError // Wirft einen Fehler, wenn die Nachricht nicht dekodiert werden kann. / Mesaj çözülemezse bir hata fırlatır.
            }
            return text // Gibt den dekodierten Text zurück. / Çözülen metni döndürür.
        } catch {
            throw ApiError.decodingError // Wirft einen Fehler, wenn die Dekodierung fehlschlägt. / Çözümleme başarısız olursa bir hata fırlatır.
        }
    }
}

