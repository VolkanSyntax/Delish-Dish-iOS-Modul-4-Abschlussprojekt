//
//  AddToDoListView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 20.07.24.
//

import SwiftUI

struct AddToDoListView: View {
    @ObservedObject var todoListViewModel: ToDoListViewModel
    @Binding var isPresented: Bool

    @State private var title: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("title")) {
                    TextField("enter_title", text: $title)
                        .autocorrectionDisabled(true)
                }
                Section(header: Text("description")) {
                    TextEditor(text: $description)
                        .frame(height: 500)
                        .autocorrectionDisabled(true)
                }
            }
            .navigationBarTitle("add_todo", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    todoListViewModel.createNewToDoItem(title: title, description: description)
                    isPresented = false
                }) {
                    Text("save")
                }
                .disabled(title.isEmpty || description.isEmpty)
            )
        }
    }
}

#Preview {
    AddToDoListView(todoListViewModel: ToDoListViewModel(), isPresented: .constant(true))
}


