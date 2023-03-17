//
//  ProfileViewModel.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/13/23.
//

import Foundation
import Firebase


class ProfileViewModel : ObservableObject {
    
    @Published var username : String
    @Published var email : String
    
    init(){
        username = Auth.auth().currentUser?.displayName ?? ""
        email = Auth.auth().currentUser?.email ?? ""
    }
    

}
