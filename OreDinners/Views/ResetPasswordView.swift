//
//  ResetPasswordView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/31/23.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State var email = ""
    @EnvironmentObject var session : SessionStore
    @State var showMessage = false
    
    var body: some View {
        ZStack {
            
            Color("MinesGrey")
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 1000, height: screenHeight * 0.6)
                .rotationEffect(.degrees(160))
                .foregroundColor(Color("MinesBlue"))
            
            VStack {
                HStack {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .padding(.leading)
                    Spacer()
                }
                
                Spacer()
                
                TextFieldView(name: "Mines Email", bindingText: $email, isSecureField: false, maxLen: 55)
                
                Button(action: {reset()}, label: {
                    Text("Reset")
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
                    Text("Remembered your password?")
                        .foregroundColor(.white)
                    Button(action: {session.displayPage = showPage.login}, label: {
                        Text("Back To Login")
                            .foregroundColor(Color("MinesRed"))
                            .bold()
                    })
                }
                
            }
            .frame(width: screenWidth, height: screenHeight * 0.45)
            .alert("Check your email!", isPresented: $showMessage, actions: {})
            
        }.ignoresSafeArea()
    }
    
    func reset(){
        session.resetPassword(email: email)
        showMessage.toggle()
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView().environmentObject(SessionStore())
    }
}
