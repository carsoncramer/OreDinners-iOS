//
//  Post.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import Foundation
import Firebase

struct Post : Identifiable {
    var id : String
    var location : String
    var time : Timestamp
    var image : String
    var userID : String
    var username : String
    var caption : String
    var isOwner : Bool
}
