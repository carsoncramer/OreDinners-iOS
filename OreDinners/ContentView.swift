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
    
    var body: some View {
        Group {
            
            switch session.displayPage {
            case .login:
                LoginView()
            case .signup:
                SignUpView()
            case .onboard:
                OnboardingView()
            case .resetpass:
                ResetPasswordView()
            case .main:
                MainView()
            case .update:
                NeedsUpdateView()
            }
            
            
//            if session.needsUpdate {
//                NeedsUpdateView()
//            }
//            else if session.session != nil {
//                MainView()
//                    .transition(.slide)
//            }
//            else if session.firstAppLaunch {
//                OnboardingView()
//                    .transition(.slide)
//            }
//            else if showLogin {
//                LoginView(showLogin: $showLogin)
//                    .transition(.slide)
//            }
//            else if !showLogin {
//                SignUpView(showLogin: $showLogin)
//                    .transition(.slide)
//            }
            
        }
        .environmentObject(session)
        .environmentObject(postRepo)
        .alert(session.alertMessage, isPresented: $session.showAlert, actions: {})
        .alert(postRepo.alertMessage, isPresented: $postRepo.showAlert, actions: {})
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
