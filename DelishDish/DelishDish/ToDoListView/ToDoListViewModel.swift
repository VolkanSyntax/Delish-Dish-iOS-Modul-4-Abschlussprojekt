//
//  ToDoListViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 19.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ToDoListViewModel: ObservableObject {
    
    @Published var todoItems: [FireToDoItem] = []
    
    private let firebaseAuthentication = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func createNewToDoItem(title: String, description: String) {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        
        let newFireToDoItem = FireToDoItem(title: title, description: description, isCompleted: false, userId: userId, sharedWith: [userId])
        
        do {
            try self.firebaseFirestore.collection("users").document(userId).collection("todos").addDocument(from: newFireToDoItem)
            self.fetchToDoItems()
        } catch {
            print(error)
        }
    }
    
    func fetchToDoItems() {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        
        self.listener = self.firebaseFirestore.collection("users").document(userId).collection("todos")
            .whereField("sharedWith", arrayContains: userId)
            .addSnapshotListener { snapshot, error in
                if let error {
                    print("Fehler beim Laden der Todos: \(error)")
                    return
                }
                
                guard let snapshot else {
                    print("Snapshot ist leer")
                    return
                }
                
                let todoItems = snapshot.documents.compactMap { document -> FireToDoItem? in
                    do {
                        return try document.data(as: FireToDoItem.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }
                
                self.todoItems = todoItems
            }
    }
    
    func updateToDoItem(withId id: String?, title: String? = nil, description: String? = nil, isCompleted: Bool? = nil) {
        guard let userId = self.firebaseAuthentication.currentUser?.uid, let id else {
            print("Item hat keine id!")
            return
        }
        
        var fieldsToUpdate = [String: Any]()
        
        if let title = title {
            fieldsToUpdate["title"] = title
        }
        
        if let description = description {
            fieldsToUpdate["description"] = description
        }
        
        if let isCompleted = isCompleted {
            fieldsToUpdate["isCompleted"] = isCompleted
        }
        
        guard !fieldsToUpdate.isEmpty else {
            print("Keine Felder zum Aktualisieren angegeben")
            return
        }
        
        firebaseFirestore.collection("users").document(userId).collection("todos").document(id).updateData(fieldsToUpdate) { error in
            if let error {
                print("Update fehlgeschlagen: \(error)")
            } else {
                print("Update erfolgreich")
                self.fetchToDoItems()
            }
        }
    }

    
    func deleteToDoItem(withId id: String?) {
        guard let userId = self.firebaseAuthentication.currentUser?.uid, let id else {
            print("Item hat keine id!")
            return
        }
        
        firebaseFirestore.collection("users").document(userId).collection("todos").document(id).delete() { error in
            if let error {
                print("Löschen fehlgeschlagen: \(error)")
            } else {
                self.fetchToDoItems()
            }
        }
    }
    
    func shareToDoItem(withId id: String?, withUserEmail email: String, completion: @escaping (Bool) -> Void) {
        guard let id else {
            print("Item hat keine id!")
            completion(false)
            return
        }

        firebaseFirestore.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting user UID: \(error)")
                completion(false)
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No user found with this email address")
                completion(false)
                return
            }

            let userId = documents[0].documentID

            self.firebaseFirestore.collection("users").document(self.firebaseAuthentication.currentUser!.uid).collection("todos").document(id).updateData([
                "sharedWith": FieldValue.arrayUnion([userId])
            ]) { error in
                if let error {
                    print("Update fehlgeschlagen: \(error)")
                    completion(false)
                } else {
                    self.firebaseFirestore.collection("users").document(self.firebaseAuthentication.currentUser!.uid).collection("todos").document(id).getDocument { (document, error) in
                        if let document = document, document.exists, var data = document.data() {
                            data["originalOwner"] = self.firebaseAuthentication.currentUser!.uid
                            self.firebaseFirestore.collection("users").document(userId).collection("todos").addDocument(data: data) { error in
                                if let error {
                                    print("Error adding shared ToDo item: \(error)")
                                    completion(false)
                                } else {
                                    print("ToDo item successfully shared with user \(email)")
                                    self.fetchToDoItems()
                                    completion(true)
                                }
                            }
                        } else {
                            print("ToDo item does not exist in the original user's collection")
                            completion(false)
                        }
                    }
                }
            }
        }
    }
}

