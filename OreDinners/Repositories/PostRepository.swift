//
//  PostRepository.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/17/23.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class PostRepository : ObservableObject {
    
    @Published var posts : [Post] = []

    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        let db = Firestore.firestore()
        let ref = db.collection("Posts")
        ref.addSnapshotListener { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let location = data["location"] as? String ?? ""
                    let time = data["timestamp"] as? Timestamp ?? Timestamp()
                    let userID = data["userID"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let caption = data["caption"] as? String ?? ""
                    
                    let post = Post(id: document.documentID, location: location, time: time, image: image, userID: userID, username: username, caption: caption, isOwner: Auth.auth().currentUser?.uid == userID)
                    if !self.posts.contains(where: {tempPost in
                        tempPost.id == post.id
                    }){
                        self.posts.append(post)
                    }
                }
            }
        }
    }
    
    func submitPost(location : String, caption : String, uiimage : UIImage) throws {
        
        guard let jpgimg = uiimage.jpegData(compressionQuality: 0.2) else {
            print("converting to jpeg failed")
            throw FirebaseErrors.ImageUploadingError
        }
        
        let postUID = UUID().uuidString
        let storage = Storage.storage()
        let imagesRef = storage.reference().child("images/\(postUID)")
        
        var shouldThrow = false
        
        _ = imagesRef.putData(jpgimg, metadata: nil, completion: { (metadata, error) in //TODO: compress the image before uploading
            
            imagesRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("downloadURL is nil")
                    shouldThrow = true
                    return
                }
                
                let db = Firestore.firestore()
                
                let data : [String : Any] = [
                    "location" : location,
                    "caption" : caption,
                    "timestamp" : Timestamp(),
                    "userID" : Auth.auth().currentUser!.uid,
                    "image" : downloadURL.absoluteString,
                    "username" : Auth.auth().currentUser!.displayName!
                ]
                
                let docRef = db.collection("Posts").document(postUID)
                
                docRef.setData(data) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                        shouldThrow = true
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                shouldThrow = true
            }
            else {
                print("image uploaded successfully")
            }
        })
        if shouldThrow {
            throw FirebaseErrors.DocumentWritingError
        }
    }
    
    
    func deletePost(post : Post) throws {
        var shouldThrow = false
        if post.isOwner {
            posts.removeAll(where: { tempPost in
                tempPost.id == post.id
            })
            let db = Firestore.firestore()
            db.collection("Posts").document(post.id).delete(completion: {error in
                if error != nil {
                    print("There was an error deleting the post")
                    shouldThrow = true
                }
                else{
                    print("Successfully deleted!")
                }
            })
            
            let storage = Storage.storage()
            storage.reference().child("images/\(post.id)").delete(completion: { error in
                if error != nil {
                    print("Image deletion failure")
                    shouldThrow = true
                }
                else {
                    print("Image successfully deleted")
                }
            })
            
        }
        else {
            print("Permission denied")
            shouldThrow = true
        }
        if shouldThrow {
            throw FirebaseErrors.DeletingPostError
        }
    }
    
    
    
}
