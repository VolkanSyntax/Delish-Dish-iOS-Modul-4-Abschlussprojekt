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
    
    @Published var todoItems: [FireToDoItem] = [] // Eine Liste der ToDo-Elemente, die vom Benutzer erstellt wurden. / Kullanıcı tarafından oluşturulan ToDo öğelerinin listesi.
    
    private let firebaseAuthentication = Auth.auth() // Eine Instanz der Firebase-Authentifizierung zum Verwalten der Benutzerauthentifizierung. / Kullanıcı kimlik doğrulamasını yönetmek için Firebase Kimlik Doğrulama örneği.
    private let firebaseFirestore = Firestore.firestore() // Eine Instanz der Firebase-Firestore-Datenbank zum Speichern und Abrufen von Daten. / Verileri depolamak ve almak için Firebase Firestore veritabanı örneği.
    private var listener: ListenerRegistration? // Eine Listener-Registrierung, um auf Änderungen in der Firestore-Datenbank zu reagieren. / Firestore veritabanındaki değişikliklere yanıt vermek için bir dinleyici kaydı.
    
    func createNewToDoItem(title: String, description: String) { // Erstellt ein neues ToDo-Element und speichert es in der Datenbank. / Yeni bir ToDo öğesi oluşturur ve bunu veritabanında depolar.
        guard let userId = self.firebaseAuthentication.currentUser?.uid else { // Überprüft, ob der Benutzer angemeldet ist. / Kullanıcının oturum açmış olup olmadığını kontrol eder.
            print("User is not signed in") // Gibt eine Meldung aus, wenn der Benutzer nicht angemeldet ist. / Kullanıcı oturum açmadıysa bir mesaj yazdırır.
            return
        }
        
        let newFireToDoItem = FireToDoItem(title: title, description: description, isCompleted: false, userId: userId, sharedWith: [userId]) // Erstellt ein neues ToDo-Element mit den angegebenen Daten. / Verilen verilerle yeni bir ToDo öğesi oluşturur.
        
        do {
            try self.firebaseFirestore.collection("users").document(userId).collection("todos").addDocument(from: newFireToDoItem) // Fügt das neue ToDo-Element zur Firestore-Datenbank hinzu. / Yeni ToDo öğesini Firestore veritabanına ekler.
            self.fetchToDoItems() // Lädt die aktualisierte Liste der ToDo-Elemente. / Güncellenmiş ToDo öğeleri listesini yükler.
        } catch {
            print(error) // Gibt eine Fehlermeldung aus, falls das Hinzufügen fehlschlägt. / Ekleme başarısız olursa bir hata mesajı yazdırır.
        }
    }
    
    func fetchToDoItems() { // Ruft die Liste der ToDo-Elemente für den aktuellen Benutzer aus der Firestore-Datenbank ab. / Firestore veritabanından geçerli kullanıcı için ToDo öğelerinin listesini alır.
        guard let userId = self.firebaseAuthentication.currentUser?.uid else { // Überprüft, ob der Benutzer angemeldet ist. / Kullanıcının oturum açmış olup olmadığını kontrol eder.
            print("User is not signed in") // Gibt eine Meldung aus, wenn der Benutzer nicht angemeldet ist. / Kullanıcı oturum açmadıysa bir mesaj yazdırır.
            return
        }
        
        self.listener = self.firebaseFirestore.collection("users").document(userId).collection("todos")
            .whereField("sharedWith", arrayContains: userId) // Filtert die ToDo-Elemente, die mit dem Benutzer geteilt wurden. / Kullanıcıyla paylaşılan ToDo öğelerini filtreler.
            .addSnapshotListener { snapshot, error in // Fügt einen Listener hinzu, um Änderungen an den ToDo-Elementen in Echtzeit zu verfolgen. / ToDo öğelerindeki değişiklikleri gerçek zamanlı olarak izlemek için bir dinleyici ekler.
                if let error {
                    print("Fehler beim Laden der Todos: \(error)") // Gibt eine Fehlermeldung aus, wenn das Laden fehlschlägt. / Yükleme başarısız olursa bir hata mesajı yazdırır.
                    return
                }
                
                guard let snapshot else {
                    print("Snapshot ist leer") // Gibt eine Meldung aus, wenn der Snapshot leer ist. / Anlık görüntü boşsa bir mesaj yazdırır.
                    return
                }
                
                let todoItems = snapshot.documents.compactMap { document -> FireToDoItem? in // Konvertiert die Dokumente aus dem Snapshot in ToDo-Elemente. / Anlık görüntüden belgeleri ToDo öğelerine dönüştürür.
                    do {
                        return try document.data(as: FireToDoItem.self) // Versucht, die Daten in ein FireToDoItem zu dekodieren. / Verileri bir FireToDoItem olarak çözmeye çalışır.
                    } catch {
                        print(error) // Gibt eine Fehlermeldung aus, wenn die Dekodierung fehlschlägt. / Çözümleme başarısız olursa bir hata mesajı yazdırır.
                    }
                    return nil
                }
                
                self.todoItems = todoItems // Aktualisiert die Liste der ToDo-Elemente im ViewModel. / ToDo öğeleri listesini ViewModel'de günceller.
            }
    }
    
    func updateToDoItem(withId id: String?, title: String? = nil, description: String? = nil, isCompleted: Bool? = nil) { // Aktualisiert ein bestehendes ToDo-Element in der Datenbank. / Veritabanındaki mevcut bir ToDo öğesini günceller.
        guard let userId = self.firebaseAuthentication.currentUser?.uid, let id else { // Überprüft, ob der Benutzer angemeldet ist und das Element eine ID hat. / Kullanıcının oturum açmış olup olmadığını ve öğenin bir kimliği olup olmadığını kontrol eder.
            print("Item hat keine id!") // Gibt eine Meldung aus, wenn das Element keine ID hat. / Öğenin kimliği yoksa bir mesaj yazdırır.
            return
        }
        
        var fieldsToUpdate = [String: Any]() // Erstellt ein Wörterbuch mit den Feldern, die aktualisiert werden sollen. / Güncellenmesi gereken alanlarla bir sözlük oluşturur.
        
        if let title = title {
            fieldsToUpdate["title"] = title // Fügt den Titel zu den zu aktualisierenden Feldern hinzu. / Güncellenecek alanlara başlığı ekler.
        }
        
        if let description = description {
            fieldsToUpdate["description"] = description // Fügt die Beschreibung zu den zu aktualisierenden Feldern hinzu. / Güncellenecek alanlara açıklamayı ekler.
        }
        
        if let isCompleted = isCompleted {
            fieldsToUpdate["isCompleted"] = isCompleted // Fügt den Fertigstellungsstatus zu den zu aktualisierenden Feldern hinzu. / Güncellenecek alanlara tamamlanma durumunu ekler.
        }
        
        guard !fieldsToUpdate.isEmpty else { // Überprüft, ob es Felder zum Aktualisieren gibt. / Güncellenecek alanlar olup olmadığını kontrol eder.
            print("Keine Felder zum Aktualisieren angegeben") // Gibt eine Meldung aus, wenn keine Felder zum Aktualisieren angegeben wurden. / Güncellenecek alan belirtilmemişse bir mesaj yazdırır.
            return
        }
        
        firebaseFirestore.collection("users").document(userId).collection("todos").document(id).updateData(fieldsToUpdate) { error in // Führt die Aktualisierung in der Datenbank durch. / Veritabanında güncellemeyi gerçekleştirir.
            if let error {
                print("Update fehlgeschlagen: \(error)") // Gibt eine Fehlermeldung aus, wenn das Update fehlschlägt. / Güncelleme başarısız olursa bir hata mesajı yazdırır.
            } else {
                print("Update erfolgreich") // Gibt eine Erfolgsmeldung aus, wenn das Update erfolgreich ist. / Güncelleme başarılı olduğunda bir başarı mesajı yazdırır.
                self.fetchToDoItems() // Lädt die aktualisierte Liste der ToDo-Elemente. / Güncellenmiş ToDo öğeleri listesini yükler.
            }
        }
    }
    
    
    func deleteToDoItem(withId id: String?) { // Löscht ein bestehendes ToDo-Element aus der Datenbank. / Veritabanından mevcut bir ToDo öğesini siler.
        guard let userId = self.firebaseAuthentication.currentUser?.uid, let id else { // Überprüft, ob der Benutzer angemeldet ist und das Element eine ID hat. / Kullanıcının oturum açmış olup olmadığını ve öğenin bir kimliği olup olmadığını kontrol eder.
            print("Item hat keine id!") // Gibt eine Meldung aus, wenn das Element keine ID hat. / Öğenin kimliği yoksa bir mesaj yazdırır.
            return
        }
        
        firebaseFirestore.collection("users").document(userId).collection("todos").document(id).delete() { error in // Löscht das ToDo-Element aus der Datenbank. / ToDo öğesini veritabanından siler.
            if let error {
                print("Löschen fehlgeschlagen: \(error)") // Gibt eine Fehlermeldung aus, wenn das Löschen fehlschlägt. / Silme başarısız olursa bir hata mesajı yazdırır.
            } else {
                self.fetchToDoItems() // Lädt die aktualisierte Liste der ToDo-Elemente. / Güncellenmiş ToDo öğeleri listesini yükler.
            }
        }
    }
    
    func shareToDoItem(withId id: String?, withUserEmail email: String, completion: @escaping (Bool) -> Void) { // Teilt ein ToDo-Element mit einem anderen Benutzer basierend auf dessen E-Mail-Adresse. / Bir ToDo öğesini, başka bir kullanıcının e-posta adresine göre paylaşır.
        guard let id else {
            print("Item hat keine id!") // Gibt eine Meldung aus, wenn das Element keine ID hat. / Öğenin kimliği yoksa bir mesaj yazdırır.
            completion(false)
            return
        }
        
        firebaseFirestore.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in // Sucht nach dem Benutzer basierend auf der E-Mail-Adresse. / E-posta adresine göre kullanıcıyı arar.
            if let error = error {
                print("Error getting user UID: \(error)") // Gibt eine Fehlermeldung aus, wenn der Benutzer nicht gefunden wird. / Kullanıcı bulunamazsa bir hata mesajı yazdırır.
                completion(false)
                return
            }
            
            guard let documents = querySnapshot?.documents, !documents.isEmpty else { // Überprüft, ob ein Benutzer mit dieser E-Mail-Adresse gefunden wurde. / Bu e-posta adresine sahip bir kullanıcı bulunup bulunmadığını kontrol eder.
                print("No user found with this email address") // Gibt eine Meldung aus, wenn kein Benutzer gefunden wird. / Kullanıcı bulunmazsa bir mesaj yazdırır.
                completion(false)
                return
            }
            
            let userId = documents[0].documentID // Ruft die Benutzer-ID des gefundenen Benutzers ab. / Bulunan kullanıcının kimliğini alır.
            
            self.firebaseFirestore.collection("users").document(self.firebaseAuthentication.currentUser!.uid).collection("todos").document(id).updateData([
                "sharedWith": FieldValue.arrayUnion([userId]) // Aktualisiert das ToDo-Element, um es mit dem gefundenen Benutzer zu teilen. / Bulunan kullanıcıyla paylaşmak için ToDo öğesini günceller.
            ]) { error in
                if let error {
                    print("Update fehlgeschlagen: \(error)") // Gibt eine Fehlermeldung aus, wenn das Teilen fehlschlägt. / Paylaşım başarısız olursa bir hata mesajı yazdırır.
                    completion(false)
                } else {
                    self.firebaseFirestore.collection("users").document(self.firebaseAuthentication.currentUser!.uid).collection("todos").document(id).getDocument { (document, error) in // Ruft das ToDo-Element ab, um es mit dem neuen Benutzer zu synchronisieren. / Yeni kullanıcıyla senkronize etmek için ToDo öğesini alır.
                        if let document = document, document.exists, var data = document.data() {
                            data["originalOwner"] = self.firebaseAuthentication.currentUser!.uid // Setzt den ursprünglichen Besitzer des ToDo-Elements. / ToDo öğesinin orijinal sahibini ayarlar.
                            self.firebaseFirestore.collection("users").document(userId).collection("todos").addDocument(data: data) { error in // Fügt das ToDo-Element in die Sammlung des neuen Benutzers hinzu. / ToDo öğesini yeni kullanıcının koleksiyonuna ekler.
                                if let error {
                                    print("Error adding shared ToDo item: \(error)") // Gibt eine Fehlermeldung aus, wenn das Hinzufügen fehlschlägt. / Ekleme başarısız olursa bir hata mesajı yazdırır.
                                    completion(false)
                                } else {
                                    print("ToDo item successfully shared with user \(email)") // Gibt eine Erfolgsmeldung aus, wenn das Teilen erfolgreich ist. / Paylaşım başarılı olduğunda bir başarı mesajı yazdırır.
                                    self.fetchToDoItems() // Lädt die aktualisierte Liste der ToDo-Elemente. / Güncellenmiş ToDo öğeleri listesini yükler.
                                    completion(true)
                                }
                            }
                        } else {
                            print("ToDo item does not exist in the original user's collection") // Gibt eine Meldung aus, wenn das ToDo-Element nicht existiert. / ToDo öğesi mevcut değilse bir mesaj yazdırır.
                            completion(false)
                        }
                    }
                }
            }
        }
    }
}


