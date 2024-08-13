//
//  OpenAI.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation


// Diese Struktur stellt die Anfragedaten dar, die an die API gesendet werden sollen.
// Bu yapı, API'ye gönderilecek istek verisini temsil eder.
struct ChatCompletionRequest: Encodable {
    let model: String // Der Name des zu verwendenden Sprachmodells. / Kullanılacak dil modeli ismi.
    let messages: [ChatMessage] // Die Chat-Nachrichten, die an die API gesendet werden sollen. / API'ye gönderilecek olan sohbet mesajları.
}

// Diese Struktur stellt eine Chat-Nachricht dar.
// Bu yapı, bir sohbet mesajını temsil eder.
struct ChatMessage: Codable {
    let role: String // Gibt an, welche Rolle die Nachricht hat (z.B. user, assistant, system). / Mesajın hangi rolde olduğunu belirtir (örn: user, assistant, system).
    let content: String // Der Inhalt der Nachricht. / Mesajın içeriği.
}

// Diese Struktur stellt die Antwortdaten dar, die von der API empfangen wurden.
// Bu yapı, API'den alınan yanıt verisini temsil eder.
struct ChatCompletionResponse: Decodable {
    struct Choice: Decodable {
        let message: ChatMessage // Eine Antwortmöglichkeit, die von der API zurückgegeben wurde. / API'nin döndürdüğü bir yanıt seçeneği.
    }
    
    let choices: [Choice] // Alle Antwortmöglichkeiten, die von der API zurückgegeben wurden. / API'den dönen tüm yanıt seçenekleri.
}


