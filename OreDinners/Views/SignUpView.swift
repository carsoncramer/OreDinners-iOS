//
//  SignUpView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @Binding var showLogin : Bool
    @EnvironmentObject var session : SessionStore
    
    var body: some View {
        ZStack {
            
            Color("MinesGrey")
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 1000, height: screenHeight * 0.6)
                .rotationEffect(.degrees(160))
                .foregroundColor(Color("MinesBlue"))
            
            VStack {
                HStack {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                
                Spacer()
                
                TextFieldView(name: "Username", bindingText: $username, isSecureField: false, maxLen: 15)
                
                TextFieldView(name: "Mines Email", bindingText: $email, isSecureField: false, maxLen: 55)
                
                TextFieldView(name: "Password", bindingText: $password, isSecureField: false, maxLen: 30)
                
                Button(action: {register()}, label: { //TODO: require username, email and password
                    Text("Sign Up")
                        .bold()
                        .frame(width: screenWidth * 0.5, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color("MinesGrey"))
                        )
                        .foregroundColor(.white)
                })
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Text("Already have an acount?")
                        .foregroundColor(.white)
                    Button(action: {showLogin.toggle()}, label: {
                        Text("Login")
                            .foregroundColor(Color("MinesRed"))
                            .bold()
                    })
                }
                
            }
            .frame(width: screenWidth, height: screenHeight * 0.45)
            .alert("Something went wrong. Please try again", isPresented: $session.showError) {
                        Button("OK", role: .cancel) { }
                    }
            
        }.ignoresSafeArea()
    }
    
    func register() {
        session.signUp(username: username, email: email, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showLogin: .constant(false)).environmentObject(SessionStore())
    }
}
