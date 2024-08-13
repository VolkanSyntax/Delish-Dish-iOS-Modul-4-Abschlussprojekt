//
//  MessageView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import SwiftUI

struct MessageView: View {
    
    let chat: Chat // Die Chat-Nachricht, die in der Ansicht angezeigt wird. / Görünümde gösterilecek sohbet mesajı.
    
    var body: some View {
        HStack {
            if chat.sender == .me { Spacer() } // Fügt einen Abstand ein, wenn der Absender der Benutzer selbst ist, um die Nachricht nach rechts zu schieben. / Eğer gönderen kullanıcı (ben) ise, mesajı sağa itmek için boşluk ekler.
            Text(chat.content) // Zeigt den Inhalt der Nachricht an. / Mesajın içeriğini gösterir.
                .foregroundColor(chat.sender == .me ? .white : nil) // Setzt die Textfarbe auf Weiß, wenn die Nachricht vom Benutzer gesendet wurde. / Eğer mesaj kullanıcıdan geldiyse, metin rengini beyaz yapar.
                .padding() // Fügt eine Innenabstand um den Text hinzu. / Metin etrafına iç boşluk ekler.
                .background(chat.sender == .me ? Color.blue : Color.gray.opacity(0.4)) // Setzt den Hintergrund der Nachricht: Blau für Benutzer, Grau für ChatGPT. / Mesajın arka plan rengini ayarlar: Kullanıcı için mavi, ChatGPT için gri.
                .cornerRadius(25) // Macht die Ecken des Nachrichtenfelds rund. / Mesaj kutusunun köşelerini yuvarlak yapar.
            if chat.sender == .chatGPT { Spacer() } // Fügt einen Abstand ein, wenn der Absender ChatGPT ist, um die Nachricht nach links zu schieben. / Eğer gönderen ChatGPT ise, mesajı sola itmek için boşluk ekler.
        }
    }
    
    static var progressView: some View {
        HStack {
            ProgressView() // Zeigt eine Ladeanzeige an. / Bir yüklenme göstergesi gösterir.
                .padding() // Fügt eine Innenabstand um die Ladeanzeige hinzu. / Yüklenme göstergesi etrafına iç boşluk ekler.
                .background(Color.gray.opacity(0.4)) // Setzt den Hintergrund der Ladeanzeige auf Grau. / Yüklenme göstergesinin arka plan rengini gri yapar.
                .cornerRadius(15) // Macht die Ecken der Ladeanzeige rund. / Yüklenme göstergesinin köşelerini yuvarlar.
            Spacer() // Fügt einen flexiblen Abstand hinzu, um die Ladeanzeige auf die linke Seite zu schieben. / Yüklenme göstergesini sola itmek için esnek bir boşluk ekler.
        }
    }
}

struct MessageBar: View {
    @Binding var message: String // Der Text der Nachricht, die der Benutzer eingibt. / Kullanıcının girdiği mesajın metni.
    var sendMessageAction: () -> Void // Die Aktion, die beim Senden einer Nachricht ausgeführt wird. / Bir mesaj gönderildiğinde gerçekleştirilecek eylem.

    var body: some View {
        HStack {
            TextField("Enter a message", text: $message, onCommit: {
                sendMessage() // Ruft die Funktion sendMessage() auf, wenn der Benutzer die Eingabetaste drückt. / Kullanıcı "Enter" tuşuna bastığında sendMessage() işlevini çağırır.
            })
                .padding(12) // Fügt eine Innenabstand um das Textfeld hinzu. / Metin alanının etrafına iç boşluk ekler.
                .background(Color(UIColor.systemGray6)) // Setzt den Hintergrund des Textfelds auf ein helles Grau. / Metin alanının arka planını açık gri yapar.
                .autocorrectionDisabled(true) // Deaktiviert die automatische Korrektur für das Textfeld. / Metin alanı için otomatik düzeltmeyi devre dışı bırakır.
                .cornerRadius(20) // Macht die Ecken des Textfelds rund. / Metin alanının köşelerini yuvarlar.
                .overlay(
                    HStack {
                        Spacer()
                        if !message.isEmpty { // Zeigt ein "X" an, wenn das Nachrichtenfeld nicht leer ist, um den Inhalt zu löschen. / Eğer mesaj alanı boş değilse, içeriği temizlemek için bir "X" simgesi gösterir.
                            Button(action: {
                                message = "" // Löscht den Inhalt des Nachrichtenfelds. / Mesaj alanının içeriğini temizler.
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray) // Setzt die Farbe des "X" auf Grau. / "X" simgesinin rengini gri yapar.
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                )
            Button(action: sendMessage) { // Schaltfläche zum Senden der Nachricht. / Mesajı göndermek için buton.
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.blue) // Setzt die Farbe des Symbols auf Blau. / Simgenin rengini mavi yapar.
                    .font(.system(size: 30)) // Setzt die Schriftgröße des Symbols auf 30. / Simgenin yazı boyutunu 30 olarak ayarlar.
                    .padding(.horizontal, 5)
            }
        }
        .padding(.horizontal) // Fügt eine horizontale Innenabstand hinzu. / Yatay iç boşluk ekler.
        .padding(.vertical, 8) // Fügt eine vertikale Innenabstand von 8 hinzu. / Dikey iç boşluk ekler.
        .background(Color(UIColor.secondarySystemBackground)) // Setzt den Hintergrund der Leiste auf die sekundäre Systemfarbe. / Çubuğun arka planını ikincil sistem rengine ayarlar.
        .cornerRadius(30) // Macht die Ecken der Leiste rund. / Çubuğun köşelerini yuvarlar.
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5) // Fügt einen Schatten unter der Leiste hinzu. / Çubuğun altına gölge ekler.
    }

    private func sendMessage() {
        if !message.isEmpty { // Prüft, ob das Nachrichtenfeld nicht leer ist, bevor die Nachricht gesendet wird. / Mesaj gönderilmeden önce mesaj alanının boş olup olmadığını kontrol eder.
            sendMessageAction() // Führt die Aktion zum Senden der Nachricht aus. / Mesajı gönderme eylemini gerçekleştirir.
            DispatchQueue.main.async {
                self.message = "" // Setzt das Nachrichtenfeld nach dem Senden der Nachricht zurück. / Mesaj gönderildikten sonra mesaj alanını sıfırlar.
            }
        }
    }
}


#Preview {
    VStack {
        MessageView(chat: Chat(id: UUID().uuidString, content: "Sample message from me", createAt: Date(), sender: .me)) // Zeigt eine Beispielnachricht in der Vorschau an. / Önizlemede örnek bir mesaj gösterir.
        Spacer()
        MessageBar(message: .constant(""), sendMessageAction: {}) // Zeigt eine Beispielnachrichteneingabeleiste in der Vorschau an. / Önizlemede örnek bir mesaj giriş çubuğu gösterir.
    }
}



