//
//  LoginViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class LoginViewModel : ObservableObject {
    
    // MARK:  VARIABLES -
    @Published private(set) var user: FireUser?
    @Published private(set) var passwordError: String?
    
    var isUserLoggeIn: Bool {
        user.self != nil
    }
    
    private var firebaseAuthentification = Auth.auth()
    private var firebaseFirestore = Firestore.firestore()
    
    init() {
        if let currentUser = self.firebaseAuthentification.currentUser {
            self.fetchFirestoreUser(withId: currentUser.uid)
        }
        
    }
    
    // MARK: functions -
    
    private func fetchFirestoreUser(withId id: String) {
        self.firebaseFirestore.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Error fetching user: \(error)")
                return
            }
            guard let document else {
                print("Document does not exist")
                return
            }
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Could not decode user: \(error)")
            }
        }
    }
    
    
    
    
    
    func login(email: String, password: String) {
        firebaseAuthentification.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error in login: \(error)")
                return
            }
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty!")
                return
            }
            print("Successfully signed in with user-Id \(authResult.user.uid) and email \(userEmail)")
            self.fetchFirestoreUser(withId: authResult.user.uid)
        }
    }
    func register(password: String, name: String, nachname: String, email: String, passwordCheck: String) {
        guard password == passwordCheck else {
            self.passwordError = "Passwörter stimmen nicht überein!"
            return
        }
        firebaseAuthentification.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error in registration: \(error)")
                return
            }
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty!")
                return
            }
            print("Successfully registered with user-Id \(authResult.user.uid) and email \(userEmail)")
            self.createFirestoreUser(id: authResult.user.uid, name: name, nachname: nachname, email: email)
            self.fetchFirestoreUser(withId: authResult.user.uid)
        }
    }
    
    private func createFirestoreUser(id: String, name: String, nachname: String, email: String) {
        let newFireUser = FireUser(id: id, name: name, nachname: nachname , email: email)
    //    try? self.firebaseFirestore.collection("users").document(id).setData(from: newFireUser)
        do {
          try self.firebaseFirestore.collection("users").document(id).setData(from: newFireUser)
        } catch {
          print("Error saving user in firestore: \(error)")
        }
      }
}
