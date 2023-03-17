//
//  LoginView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
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
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                
                Spacer()
                
                TextFieldView(name: "Email", bindingText: $email, isSecureField: false)
                
                TextFieldView(name: "Password", bindingText: $password, isSecureField: true)
                
                Button(action: {login()}, label: {
                    Text("Login")
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
                    Text("Don't have an acount?")
                        .foregroundColor(.white)
                    Button(action: {showLogin.toggle()}, label: {
                        Text("Sign Up")
                            .foregroundColor(Color("MinesRed"))
                            .bold()
                    })
                }
                
            }
            .frame(width: screenWidth, height: screenHeight * 0.45)
            .alert("Incorrect Username or Password", isPresented: $session.showError) {
                        Button("OK", role: .cancel) { }
                    }
        }.ignoresSafeArea()
    }
    
    func login() {
        session.signIn(email: email, password: password)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showLogin: .constant(true)).environmentObject(SessionStore())
    }
}
