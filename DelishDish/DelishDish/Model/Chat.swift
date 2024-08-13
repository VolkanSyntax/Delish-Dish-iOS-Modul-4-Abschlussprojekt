//
//  Chat.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import Foundation

// Diese Struktur stellt eine Chat-Nachricht dar.
// Bu yapı, bir sohbet mesajını temsil eder.
struct Chat {
    let id: String // Eindeutige ID für jede Nachricht. / Her mesaj için benzersiz bir kimlik.
    let content: String // Der Inhalt der Nachricht. / Mesajın içeriği.
    let createAt: Date // Das Erstellungsdatum der Nachricht. / Mesajın oluşturulma tarihi.
    let sender: Sender // Der Absender der Nachricht. / Mesajın göndericisi.
}

// Diese Aufzählung gibt an, wer der Absender der Nachricht ist.
// Bu enum, mesajın kimin tarafından gönderildiğini belirtir.
enum Sender {
    case me // Der Benutzer selbst. / Kullanıcı (ben).
    case chatGPT // Das ChatGPT-Modell. / ChatGPT modeli.
}

// Diese Erweiterung enthält Beispieldaten für Chat-Nachrichten.
// Bu extension, sohbet mesajları için örnek veriler içerir.
extension Chat {
    static let sampleChat: [Chat] = [
        Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me), // Beispielnachricht vom Benutzer. / Kullanıcıdan gelen örnek mesaj.
        Chat(id: UUID().uuidString, content: "Sample message from chatGPT", createAt: Date(), sender: .chatGPT), // Beispielnachricht von ChatGPT. / ChatGPT'den gelen örnek mesaj.
        Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me), // Beispielnachricht vom Benutzer. / Kullanıcıdan gelen örnek mesaj.
        Chat(id: UUID().uuidString, content: "Sample message from chatGPT", createAt: Date(), sender: .chatGPT), // Beispielnachricht von ChatGPT. / ChatGPT'den gelen örnek mesaj.
    ]
}


