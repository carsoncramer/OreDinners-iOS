//
//  SessionStore.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/13/23.
//

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
    @Published var session: User?
    @Published var showError = false
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
            handle =  Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    self.session = user
                } else {
                    self.session = nil
                }
            }
        }
    
    func signUp(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                self.showError.toggle()
                return
            }
            else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { (error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        self.showError.toggle()
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
            "posts" : []
        ]
        
        let docRef = db.collection("Users").document(uid)
        
        docRef.setData(data) { error in
            if let error = error {
                self.showError = true
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
                self.showError.toggle()
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
        } catch {
            showError.toggle()
        }
    }
    
    func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    
}
