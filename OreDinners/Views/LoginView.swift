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
                
                TextFieldView(name: "Mines Email", bindingText: $email, isSecureField: false, maxLen: 55)
                
                TextFieldView(name: "Password", bindingText: $password, isSecureField: true, maxLen: 40)
                
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
                    Button(action: {session.displayPage = showPage.signup}, label: {
                        Text("Sign Up")
                            .foregroundColor(Color("MinesRed"))
                            .bold()
                    })
                }
                Button(action: {session.displayPage = showPage.resetpass}, label: {
                    Text("Forgot Password?")
                        .foregroundColor(Color("MinesRed"))
                        .bold()
                })
                .padding()
                
            }
            .frame(width: screenWidth, height: screenHeight * 0.45)
        }.ignoresSafeArea()
    }
    
    func login() {
        session.signIn(email: email, password: password)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionStore())
    }
}
