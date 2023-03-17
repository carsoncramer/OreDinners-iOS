//
//  PostViewModel.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/13/23.
//

import Foundation
import Firebase
import FirebaseStorage

class PostViewModel : ObservableObject {
    
    @Published var post : Post
    @Published var timeSince = ""
    
    
    init(post : Post){
        self.post = post
        self.timeSince = getTimeSince()
    }
    
    func getTimeSince() -> String {
        
        
        
        let now = Timestamp()
        var difference = now.seconds - post.time.seconds
        var output = "just now"
        
        print("now:\(now) - post.time:\(post.time.seconds) = \(difference)")
        
        if difference <= 60 {
            output = "\(difference) second\(difference == 1 ? "" : "s") ago"
        }
        else if(difference <= 60 * 60) {
            difference /= 60
            output = "\(difference) minute\(difference == 1 ? "" : "s") ago"
        }
        else if(difference <= 60 * 60 * 60) {
            difference /= 60 * 60
            output = "\(difference) hour\(difference == 1 ? "" : "s") ago"
        }
        else {
            difference /= 60 * 60 * 24
            output = "\(difference) day\(difference == 1 ? "" : "s") ago"
        }
        return output
    }
    
}
