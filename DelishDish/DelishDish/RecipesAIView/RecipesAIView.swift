//
//  RecipesAIView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 07.08.24.
//

import SwiftUI

struct RecipesAIView: View {
    
    @StateObject var viewModel = RecipesAIViewModel() // Erzeugt und verwaltet eine Instanz des ViewModels. / ViewModel'in bir örneğini oluşturur ve yönetir.
    
    var body: some View {
        NavigationStack { // Stellt eine Navigation für die Ansicht bereit. / Görünüm için bir gezinme sağlar.
            VStack {
                ScrollViewReader { proxy in // Ermöglicht das Scrollen zu bestimmten Ansichten innerhalb der ScrollView. / ScrollView içinde belirli görünümlere kaydırmayı sağlar.
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.chats, id: \.id) { chat in // Durchläuft die Chat-Nachrichten und zeigt jede Nachricht an. / Sohbet mesajlarını döngüyle geçirir ve her mesajı gösterir.
                                MessageView(chat: chat) // Zeigt eine einzelne Chat-Nachricht an. / Tek bir sohbet mesajını gösterir.
                                    .contextMenu {
                                        Button(action: {
                                            UIPasteboard.general.string = chat.content // Ermöglicht das Kopieren des Nachrichteninhalts. / Mesaj içeriğini kopyalamayı sağlar.
                                        }) {
                                            Text("Copy") // Zeigt "Copy" im Kontextmenü an. / Bağlam menüsünde "Kopyala" ifadesini gösterir.
                                            Image(systemName: "doc.on.doc")
                                        }
                                    }
                                    .id(chat.id) // Weist jeder Nachricht eine eindeutige ID zu. / Her mesaja benzersiz bir kimlik atar.
                            }
                            if viewModel.isLoading { // Zeigt eine Fortschrittsanzeige, wenn Nachrichten geladen werden. / Mesajlar yüklenirken bir ilerleme göstergesi gösterir.
                                MessageView.progressView
                            }
                        }
                        .onChange(of: viewModel.chats.count) { oldValue, newValue in // Scrollt automatisch zur letzten Nachricht, wenn eine neue Nachricht hinzugefügt wird. / Yeni bir mesaj eklendiğinde otomatik olarak son mesaja kaydırır.
                            if oldValue != newValue, let lastChatId = viewModel.chats.last?.id {
                                withAnimation {
                                    proxy.scrollTo(lastChatId, anchor: .bottom) // Scrollt zu der letzten Nachricht. / Son mesaja kaydırır.
                                }
                            }
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom, 1)
                
                MessageBar(message: $viewModel.message, sendMessageAction: {
                    viewModel.sendMessage() // Ruft die Methode zum Senden einer Nachricht auf. / Mesaj göndermek için işlevi çağırır.
                })
            }
            .padding()
            .navigationTitle("RecipesAI Generator") // Setzt den Titel der Navigationsleiste. / Gezinme çubuğu başlığını ayarlar.
            .navigationBarTitleDisplayMode(.inline) // Stellt sicher, dass der Titel im Inline-Modus angezeigt wird. / Başlığın satır içi modda gösterilmesini sağlar.
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.chats.removeAll() // Entfernt alle Nachrichten. / Tüm mesajları siler.
                    } label: {
                        Image(systemName: "trash.fill")
                            .font(.caption)
                        Text("Clear All") // Zeigt "Clear All" an, um alle Nachrichten zu löschen. / Tüm mesajları silmek için "Hepsini Sil" ifadesini gösterir.
                            .font(.footnote)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesAIView() // Zeigt eine Vorschau der RecipesAIView an. / RecipesAIView'un bir önizlemesini gösterir.
        .environmentObject(RecipesAIViewModel()) // Stellt das ViewModel für die Vorschau bereit. / Önizleme için ViewModel'i sağlar.
}













