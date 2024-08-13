//
//  EditToDoListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.07.24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EditToDoListView: View {
    @Binding var isPresented: Bool
    @ObservedObject var todoListViewModel: ToDoListViewModel
    @State var todoItem: FireToDoItem

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $todoItem.title)
                        .autocorrectionDisabled(true)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $todoItem.description)
                        .frame(height: 500)
                        .autocorrectionDisabled(true)
                        .onChange(of: todoItem.description) {
                            print("Description updated: \(todoItem.description)")
                        }
                }
            }
            .navigationBarTitle("Edit ToDo", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    todoListViewModel.updateToDoItem(withId: todoItem.id, title: todoItem.title, description: todoItem.description)
                    isPresented = false
                }) {
                    Text("Save")
                }
                .disabled(todoItem.title.isEmpty || todoItem.description.isEmpty)
            )
        }
    }
}

#Preview {
    EditToDoListView(isPresented: .constant(true), todoListViewModel: ToDoListViewModel(), todoItem: FireToDoItem(title: "Test", description: "Test description", isCompleted: false, userId: "123", sharedWith: ["123"]))
}
