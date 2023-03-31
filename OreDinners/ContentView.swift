//
//  ContentView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var session = SessionStore()
    @ObservedObject var postRepo = PostRepository()
    @State private var showLogin = false //false means show sign up
    
    var body: some View {
        Group {
            if session.session != nil {
                MainView()
                    .transition(.slide)
            }
            else{
                if session.firstAppLaunch {
                    OnboardingView()
                        .transition(.slide)
                }
                else {
                    if showLogin {
                        LoginView(showLogin: $showLogin)
                            .transition(.slide)
                    }
                    else{
                        SignUpView(showLogin: $showLogin)
                            .transition(.slide)
                    }
                }
            }
        }
        .environmentObject(session)
        .environmentObject(postRepo)
        .onAppear(perform: {session.listen()})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
