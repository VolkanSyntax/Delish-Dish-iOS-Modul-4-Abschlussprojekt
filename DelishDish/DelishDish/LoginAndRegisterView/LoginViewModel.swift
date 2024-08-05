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
    
    // MARK:  VARIABLES -------------------------------------------------------------------------
    
    @Published private(set) var user: FireUser? // Definiert eine veröffentlichte, private Variable vom Typ FireUser / FireUser türünde yayımlanan, özel bir değişken tanımlar
    @Published private(set) var passwordError: String? // Definiert eine veröffentlichte, private Variable für Passwortfehler / Parola hatası için yayımlanan, özel bir değişken tanımlar
    
    var isUserLoggeIn: Bool { // Definiert eine berechnete Variable, die überprüft, ob der Benutzer eingeloggt ist / Kullanıcının oturum açıp açmadığını kontrol eden hesaplanmış bir değişken tanımlar
        user.self != nil // Überprüft, ob der Benutzer nicht nil ist / Kullanıcının nil olup olmadığını kontrol eder
    }
    
    private var firebaseAuthentification = Auth.auth() // Initialisiert die Firebase-Authentifizierung / Firebase kimlik doğrulamasını başlatır
    private var firebaseFirestore = Firestore.firestore() // Initialisiert Firestore-Datenbank / Firestore veritabanını başlatır
    
    init() { // Initialisierungsfunktion / Başlatma fonksiyonu
        if let currentUser = self.firebaseAuthentification.currentUser { // Überprüft, ob ein Benutzer eingeloggt ist / Bir kullanıcının oturum açıp açmadığını kontrol eder
            self.fetchFirestoreUser(withId: currentUser.uid) // Ruft die Firestore-Benutzerdaten ab / Firestore kullanıcı verilerini getirir
        }
    }
    
    // MARK: functions --------------------------------------------------------------------------
    
    private func fetchFirestoreUser(withId id: String) { // Definiert eine private Funktion zur Benutzerabfrage / Kullanıcı sorgulaması için özel bir fonksiyon tanımlar
        self.firebaseFirestore.collection("users").document(id).getDocument { document, error in // Holt das Dokument des Benutzers aus Firestore / Kullanıcının belgesini Firestore'dan alır
            if let error { // Überprüft auf Fehler / Hataları kontrol eder
                print("Error fetching user: \(error)") // Gibt einen Fehler aus / Bir hata yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            guard let document else { // Überprüft, ob das Dokument existiert / Belgenin var olup olmadığını kontrol eder
                print("Document does not exist") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            do { // Versucht, den Benutzer zu decodieren / Kullanıcıyı çözmeyi dener
                let user = try document.data(as: FireUser.self) // Dekodiert das Dokument in ein FireUser-Objekt / Belgeyi bir FireUser nesnesine dönüştürür
                self.user = user // Setzt den Benutzer / Kullanıcıyı ayarlar
            } catch { // Fängt Decodierungsfehler ab / Çözümleme hatalarını yakalar
                print("Could not decode user: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
            }
        }
    }
    
    func login(email: String, password: String) { // Definiert eine Funktion zur Benutzeranmeldung / Kullanıcı girişini yapan bir fonksiyon tanımlar
        firebaseAuthentification.signIn(withEmail: email, password: password) { authResult, error in // Versucht, sich mit E-Mail und Passwort anzumelden / E-posta ve parola ile oturum açmayı dener
            if let error { // Überprüft auf Fehler / Hataları kontrol eder
                print("Error in login: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            guard let authResult, let userEmail = authResult.user.email else { // Überprüft das Ergebnis und die E-Mail des Benutzers / Sonucu ve kullanıcının e-postasını kontrol eder
                print("authResult or Email are empty!") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            print("Successfully signed in with user-Id \(authResult.user.uid) and email \(userEmail)") // Erfolgreiche Anmeldungsmeldung / Başarılı giriş mesajı yazdırır
            self.fetchFirestoreUser(withId: authResult.user.uid) // Ruft die Firestore-Benutzerdaten ab / Firestore kullanıcı verilerini getirir
        }
    }
    
    func register(password: String, name: String, nachname: String, email: String, passwordCheck: String) { // Definiert eine Funktion zur Benutzerregistrierung / Kullanıcı kaydı yapan bir fonksiyon tanımlar
        guard password == passwordCheck else { // Überprüft, ob die Passwörter übereinstimmen / Parolaların eşleşip eşleşmediğini kontrol eder
            self.passwordError = "Passwörter stimmen nicht überein!" // Setzt einen Passwortfehler / Parola hatasını ayarlar
            return // Beendet die Funktion / Fonksiyonu sonlandırır
        }
        firebaseAuthentification.createUser(withEmail: email, password: password) { authResult, error in // Versucht, einen neuen Benutzer zu erstellen / Yeni bir kullanıcı oluşturmayı dener
            if let error { // Überprüft auf Fehler / Hataları kontrol eder
                print("Error in registration: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            guard let authResult, let userEmail = authResult.user.email else { // Überprüft das Ergebnis und die E-Mail des Benutzers / Sonucu ve kullanıcının e-postasını kontrol eder
                print("authResult or Email are empty!") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
                return // Beendet die Funktion / Fonksiyonu sonlandırır
            }
            print("Successfully registered with user-Id \(authResult.user.uid) and email \(userEmail)") // Erfolgreiche Registrierungsmeldung / Başarılı kayıt mesajı yazdırır
            
            self.createFirestoreUser(id: authResult.user.uid, name: name, nachname: nachname, email: email) // Erstellt einen neuen Firestore-Benutzer / Yeni bir Firestore kullanıcısı oluşturur
            
            self.fetchFirestoreUser(withId: authResult.user.uid) // Ruft die Firestore-Benutzerdaten ab / Firestore kullanıcı verilerini getirir
        }
    }
    
    private func createFirestoreUser(id: String, name: String, nachname: String, email: String) { // Definiert eine Funktion zum Erstellen eines Firestore-Benutzers / Firestore kullanıcısı oluşturma fonksiyonu tanımlar
        let newFireUser = FireUser(id: id, name: name, nachname: nachname, email: email) // Erstellt ein neues FireUser-Objekt / Yeni bir FireUser nesnesi oluşturur
        do { // Versucht, den Benutzer in Firestore zu speichern / Kullanıcıyı Firestore'a kaydetmeyi dener
            try self.firebaseFirestore.collection("users").document(id).setData(from: newFireUser) // Speichert den Benutzer in Firestore / Kullanıcıyı Firestore'a kaydeder
        } catch { // Fängt Speicherfehler ab / Kayıt hatalarını yakalar
            print("Error saving user in firestore: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
        }
    }
    
    func logout() { // Definiert eine Funktion zur Benutzerabmeldung / Kullanıcı çıkışını yapan bir fonksiyon tanımlar
        do { // Versucht, den Benutzer abzumelden / Kullanıcıyı oturumdan çıkarmayı dener
            try firebaseAuthentification.signOut() // Meldet den Benutzer ab / Kullanıcının oturumunu kapatır
            
            self.user = nil // Setzt den Benutzer auf nil / Kullanıcıyı nil olarak ayarlar
        } catch { // Fängt Abmeldefehler ab / Çıkış hatalarını yakalar
            print("Error in logout: \(error)") // Gibt eine Fehlermeldung aus / Bir hata mesajı yazdırır
        }
    }
    
}
