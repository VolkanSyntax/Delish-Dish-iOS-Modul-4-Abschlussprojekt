//
//  ToDoListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 10.07.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct ToDoListView: View {
    
    @StateObject private var todoListViewModel = ToDoListViewModel()
    
    
    
    // Zustand, um die Benutzeroberfläche zum Hinzufügen eines neuen To-Do-Elements zu öffnen und zu schließen.
    // Yeni bir yapılacak öğesi eklemek için kullanıcının arayüzünü açıp kapatmak için kullanılan durum.
    @State private var showNewToDoItem = false
    // Zustand, um die Benutzeroberfläche zum Bearbeiten des ausgewählten To-Do-Elements zu öffnen und zu schließen.
    // Seçili yapılacak öğeyi düzenlemek için kullanıcının arayüzünü açıp kapatmak için kullanılan durum.
    @State private var showEditToDoItem = false
    // Zustand, um das Freigabe-Alarmfenster anzuzeigen.
    // Paylaşım uyarı penceresini göstermek için kullanılan durum.
    @State private var showShareAlert = false
    // Zustand, um das Benachrichtigungsfenster mit dem Freigabeergebnis anzuzeigen.
    // Paylaşım sonucunu gösteren uyarı penceresini göstermek için kullanılan durum.
    @State private var showShareResultAlert = false
    // Speichert das Ergebnis des Freigabevorgangs.
    // Paylaşım işleminin sonucunu saklar.
    @State private var shareResultMessage = ""
    // Speichert die E-Mail des Benutzers, mit dem das To-Do-Element geteilt wird.
    // Yapılacak öğenin paylaşılacağı kullanıcının e-posta adresini saklar.
    @State private var userEmailToShare = ""
    // Speichert das aktuell ausgewählte To-Do-Element.
    // Şu anda seçili olan yapılacak öğeyi saklar.
    @State private var selectedToDoItem: FireToDoItem?
    var body: some View {
        NavigationStack {
            VStack {
                // Liste der To-Do-Elemente, die aus dem ViewModel abgerufen wurden.
                // ViewModel'den alınan yapılacak öğelerin listesi.
                List(todoListViewModel.todoItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            // Anzeige des Titels des To-Do-Elements.
                            // Yapılacak öğenin başlığını gösterir.
                            Text(item.title)
                                .font(.headline)
                                .foregroundColor(.red)
                            
                            // Anzeige der Beschreibung des To-Do-Elements.
                            // Yapılacak öğenin açıklamasını gösterir.
                            Text(item.description)
                                .font(.body)
                                .lineLimit(2)
                        }
                        Spacer()
                        
                        if item.isCompleted {
                            // Zeigt ein Häkchen, wenn das To-Do-Element abgeschlossen ist.
                            // Yapılacak öğe tamamlandığında bir onay işareti gösterir.
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                                .font(.system(size: 21))
                                .onTapGesture {
                                    todoListViewModel.updateToDoItem(withId: item.id, isCompleted: false)
                                }
                        } else {
                            // Zeigt einen leeren Kreis, wenn das To-Do-Element nicht abgeschlossen ist.
                            // Yapılacak öğe tamamlanmadığında boş bir daire gösterir.
                            Image(systemName: "circle")
                                .font(.system(size: 21))
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    todoListViewModel.updateToDoItem(withId: item.id, isCompleted: true)
                                }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedToDoItem = item
                        showEditToDoItem = true
                    }
                    .swipeActions {
                        // Schaltfläche zum Löschen des To-Do-Elements.
                        // Yapılacak öğeyi silmek için düğme.
                        Button("Löschen", role: .destructive) {
                            todoListViewModel.deleteToDoItem(withId: item.id)
                        }
                        
                        // Schaltfläche zum Teilen des To-Do-Elements.
                        // Yapılacak öğeyi paylaşmak için düğme.
                        Button(action: {
                            showShareAlert = true
                            selectedToDoItem = item
                        }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .tint(.blue)
                    }
                }
                .onAppear {
                    // Lädt die To-Do-Elemente, wenn die Ansicht erscheint.
                    // Görünüm göründüğünde yapılacak öğeleri yükler.
                    todoListViewModel.fetchToDoItems()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        // Schaltfläche zum Hinzufügen eines neuen To-Do-Elements.
                        // Yeni bir yapılacak öğe eklemek için düğme.
                        Button(action: {
                            showNewToDoItem = true
                        }) {
                            Label("Hinzufügen", systemImage: "plus.circle.fill")
                        }
                    }
                }
                .alert("ToDo Teilen", isPresented: $showShareAlert, actions: {
                    // Eingabefeld für die E-Mail des Benutzers, mit dem das To-Do-Element geteilt werden soll.
                    // Yapılacak öğenin paylaşılacağı kullanıcının e-posta adresini girmek için giriş alanı.
                    TextField("Benutzer E-Mail", text: $userEmailToShare)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    HStack {
                        // Schaltfläche zum Bestätigen des Teilens.
                        // Paylaşımı onaylamak için düğme.
                        Button("Teilen") {
                            if let item = selectedToDoItem {
                                todoListViewModel.shareToDoItem(withId: item.id, withUserEmail: userEmailToShare) { success in
                                    shareResultMessage = success ? "Teilen erfolgreich" : "Fehler beim Teilen"
                                    showShareResultAlert = true
                                }
                            }
                            userEmailToShare = ""
                            showShareAlert = false
                        }
                        // Schaltfläche zum Abbrechen der Freigabe.
                        // Paylaşımı iptal etmek için düğme.
                        Button("Abbrechen") {
                            userEmailToShare = ""
                            showShareAlert = false
                        }
                        .foregroundColor(.cyan)
                    }
                })
                .alert(shareResultMessage, isPresented: $showShareResultAlert) {
                    // Schaltfläche zum Schließen des Freigabeergebnis-Alerts.
                    // Paylaşım sonucu uyarısını kapatmak için düğme.
                    Button("OK", role: .cancel) { }
                }
                .navigationDestination(isPresented: $showNewToDoItem) {
                    // Zeigt die Ansicht zum Hinzufügen eines neuen To-Do-Elements an.
                    // Yeni bir yapılacak öğe ekleme görünümünü gösterir.
                    AddToDoListView(todoListViewModel: todoListViewModel, isPresented: $showNewToDoItem)
                }
                .navigationDestination(isPresented: $showEditToDoItem) {
                    if let selectedItem = selectedToDoItem {
                        // Zeigt die Ansicht zum Bearbeiten des ausgewählten To-Do-Elements an.
                        // Seçili yapılacak öğeyi düzenleme görünümünü gösterir.
                        EditToDoListView(
                            isPresented: $showEditToDoItem,
                            todoListViewModel: todoListViewModel,
                            todoItem: selectedItem
                        )
                    }
                }
                // Setzt den Titel der Navigationsleiste.
                // Gezinti çubuğu başlığını ayarlar.
                .navigationTitle("Meine ToDo Liste")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onChange(of: showShareAlert) { oldValue, newValue in
            if newValue == false {
                // Löscht die Benutzer-E-Mail, wenn das Freigabe-Alertfenster geschlossen wird.
                // Paylaşım uyarı penceresi kapatıldığında kullanıcı e-postasını temizler.
                userEmailToShare = ""
            }
        }
    }
}

#Preview {
    ToDoListView()
        .environmentObject(LoginViewModel())
}





