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
                Section(header: Text("title")) {
                    TextField("enter_title", text: $todoItem.title)
                        .autocorrectionDisabled(true)
                }
                Section(header: Text("description")) {
                    TextEditor(text: $todoItem.description)
                        .frame(height: 500)
                        .autocorrectionDisabled(true)
                        .onChange(of: todoItem.description) {
                            print("description_updated \(todoItem.description)")
                        }
                }
            }
            .navigationBarTitle("edit_todo", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    todoListViewModel.updateToDoItem(withId: todoItem.id, title: todoItem.title, description: todoItem.description)
                    isPresented = false
                }) {
                    Text("save")
                }
                    .disabled(todoItem.title.isEmpty || todoItem.description.isEmpty)
            )
        }
    }
}

#Preview {
    EditToDoListView(isPresented: .constant(true), todoListViewModel: ToDoListViewModel(), todoItem: FireToDoItem(title: "Test", description: "Test description", isCompleted: false, userId: "123", sharedWith: ["123"]))
}
