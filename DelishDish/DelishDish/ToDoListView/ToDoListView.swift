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
    @EnvironmentObject private var loginViewModel: LoginViewModel

    @State private var showNewToDoItem = false
    @State private var showEditToDoItem = false
    @State private var showShareAlert = false
    @State private var userEmailToShare = ""
    @State private var selectedToDoItem: FireToDoItem?

    var body: some View {
        NavigationStack {
            VStack {
                List(todoListViewModel.todoItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                                .foregroundColor(.red)
                            Text(item.description)
                                .font(.body)
                                .lineLimit(2)
                        }
                        Spacer()
                        if item.isCompleted {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                                .font(.system(size: 21))
                                .onTapGesture {
                                    todoListViewModel.updateToDoItem(withId: item.id, isCompleted: false)
                                }
                        } else {
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
                        Button("Löschen", role: .destructive) {
                            todoListViewModel.deleteToDoItem(withId: item.id)
                        }
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
                    todoListViewModel.fetchToDoItems()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showNewToDoItem = true
                        }) {
                            Label("Hinzufügen", systemImage: "plus.circle.fill")
                        }
                    }
                }
                .alert("ToDo Teilen", isPresented: $showShareAlert) {
                    VStack {
                        TextField("Benutzer E-Mail", text: $userEmailToShare)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        HStack {
                            Button("Teilen") {
                                if let item = selectedToDoItem {
                                    todoListViewModel.shareToDoItem(withId: item.id, withUserEmail: userEmailToShare)
                                }
                                showShareAlert = false
                            }
                            Button("Abbrechen") {
                                showShareAlert = false
                            }
                            .foregroundColor(.cyan)
                        }
                    }
                    .padding()
                }
                .navigationDestination(isPresented: $showNewToDoItem) {
                    AddToDoListView(todoListViewModel: todoListViewModel, isPresented: $showNewToDoItem)
                }
                .navigationDestination(isPresented: $showEditToDoItem) {
                    if let selectedItem = selectedToDoItem {
                        EditToDoListView(
                            isPresented: $showEditToDoItem,
                            todoListViewModel: todoListViewModel,
                            todoItem: selectedItem
                        )
                    }
                }
                .navigationTitle("Meine ToDo Liste")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ToDoListView()
        .environmentObject(LoginViewModel())
}
