//
//  OreDinnersApp.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct OreDinnersApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
