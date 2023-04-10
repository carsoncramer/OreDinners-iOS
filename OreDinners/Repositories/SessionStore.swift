//
//  SessionStore.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/13/23.
//

import Foundation
import Combine
import Firebase
import FirebaseCore

enum showPage {
    case login, signup, resetpass, update, main, onboard
}

class SessionStore: ObservableObject {
    @Published var session: User?
    @Published var showAlert = false
    @Published var alertMessage = ""
    var handle: AuthStateDidChangeListenerHandle?
    @Published var displayPage = showPage.signup
    var firstRun = false
    
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            displayPage = showPage.onboard
            firstRun = true
        }
        
        listen()
        
        checkForUpdate()
        
    }
    
    func checkForUpdate() {
        let db = Firestore.firestore()
        let ref = db.collection("AppInfo").document("CurrentApp")
        
        ref.getDocument(completion: { document, error in
            if let document = document, document.exists {
                let docData = document.data()
                let version = docData?["version"] as? String ?? ""
                if APP_VERSION != version {
                    self.displayPage = showPage.update
                }
            }
            
        })
        
    }
    
    
    func listen() {
        handle =  Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = user
                self.displayPage = showPage.main
            } else {
                self.session = nil
                if !self.firstRun {
                    self.displayPage = showPage.login
                }
                else{
                    self.firstRun = false //show onboarding first and then the log out screen will stil work
                }
                
            }
        }
    }
    
    func signUp(username: String, email: String, password: String) {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            alertMessage = "Make sure to fill out all fields!"
            showAlert.toggle()
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                self.alertMessage = error!.localizedDescription
                self.showAlert.toggle()
                return
            }
            else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        self.alertMessage = error!.localizedDescription
                        self.showAlert.toggle()
                        return
                    }
                    else {
                        print("displayName set")
                        
                    }
                }
                print("success")
                //great success
                if let result = result {
                    self.addUserToDB(email: email, username: username, uid: result.user.uid)
                }
            }
        }
        
        
    }
    
    func addUserToDB(email: String, username: String, uid: String) {
        let db = Firestore.firestore()
        
        let data : [String : Any] = [
            "email" : email,
            "username" : username,
            "creationDate" : Timestamp(),
            "posts" : [] as [String],
            "blocked" : [] as [String]
        ]
        
        let docRef = db.collection("Users").document(uid)
        
        docRef.setData(data) { error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    
    
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.alertMessage = error!.localizedDescription
                self.showAlert.toggle()
            } else {
                print("success")
                //login
            }
        }
    }
    
    func signOut () {
        do {
            try Auth.auth().signOut()
            self.session = nil
            displayPage = .login
        } catch {
            alertMessage = "There was an error while signing out."
            showAlert.toggle()
        }
    }
    
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: "email@email") { error in
            self.alertMessage = "There was an error resetting your password."
            self.showAlert.toggle()
        }

    }
    
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func deleteAccount() {
        let db = Firestore.firestore()
        db.collection("Users").document(Auth.auth().currentUser!.uid).delete(completion: {error in
            if error != nil {
                print("There was an error deleting the user")
                self.alertMessage = "There was an error deleting the user"
                self.showAlert.toggle()
            }
            else{
                print("Successfully deleted!")
            }
        })
        
        Auth.auth().currentUser?.delete() { error in
            if error != nil {
                self.alertMessage = "There was an error deleting your account, please contact ctcramer@mines.edu"
                self.showAlert.toggle()
            }
            else{
                self.session = nil
                self.displayPage = .login
                self.alertMessage = "Account successfully deleted."
                self.showAlert.toggle()
            }
        }
    }
    
    func blockUser(uid : String) {
        let db = Firestore.firestore()
        let currentUserRef = db.collection("Users").document(Auth.auth().currentUser!.uid)
        currentUserRef.updateData([
            "blocked" : FieldValue.arrayUnion([uid])
        ])
    }
    
}
