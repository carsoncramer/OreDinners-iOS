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
    @State private var checked = false
    @State private var showEULA = false
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
                
                HStack {
                    CheckBoxView(checked: $checked)
                    Text("I agree to the ")
                    Button(action: {showEULA.toggle()}, label: {
                        Text("OreDinners EULA")
                            .foregroundColor(Color("MinesRed"))
                    })
                }
                
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
                    Button(action: {session.displayPage = showPage.login}, label: {
                        Text("Login")
                            .foregroundColor(Color("MinesRed"))
                            .bold()
                    })
                }
                
            }
            .frame(width: screenWidth, height: screenHeight * 0.45)
           
        }.ignoresSafeArea()
            .sheet(isPresented: $showEULA, content: {
                ZStack {
                    Color.white.ignoresSafeArea()
                    ScrollView {
                        Text("""
                    END USER LICENSE AGREEMENT (EULA) FOR OREDINNERS
                
                    IMPORTANT-READ CAREFULLY: This End User License Agreement ("EULA") is a legal agreement between you (either an individual or a single entity) and OreDinners regarding the OreDinners mobile application ("Software"). By downloading or using the Software, you agree to be bound by the terms of this EULA. If you do not agree to the terms of this EULA, do not download or use the Software.
                
                    LICENSE GRANT: OreDinners grants you a non-exclusive, non-transferable, limited license to use the Software solely for your personal, non-commercial use, subject to the terms and conditions of this EULA.
                
                    RESTRICTIONS: You may not rent, lease, lend, sell, redistribute, or sublicense the Software. You may not copy, modify, adapt, translate, or create derivative works based on the Software or any part thereof.
                
                    OBJECTIONABLE CONTENT: OreDinners does not tolerate objectionable content on its platform. You agree that you will not post or transmit any objectionable content, including but not limited to content that is unlawful, threatening, abusive, harassing, defamatory, obscene, vulgar, or otherwise objectionable. OreDinners reserves the right to remove any objectionable content and to terminate your access to the Software if you violate this provision.
                
                    ABUSIVE USERS: OreDinners has a zero-tolerance policy for abusive users. You agree that you will not engage in any abusive behavior, including but not limited to behavior that is harmful, threatening, or harassing to other users. OreDinners reserves the right to suspend or terminate your account if you engage in any abusive behavior.
                
                    OWNERSHIP: The Software is owned and copyrighted by OreDinners. Your license confers no title or ownership in the Software and should not be construed as a sale of any right in the Software.
                
                    TERMINATION: This EULA will terminate immediately if you fail to comply with any term or condition of this EULA. Upon termination, you must immediately cease using the Software and destroy all copies of the Software.
                
                    DISCLAIMER OF WARRANTIES: THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. OREDINNERS DOES NOT WARRANT THAT THE SOFTWARE WILL MEET YOUR REQUIREMENTS OR THAT THE OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE.
                
                    LIMITATION OF LIABILITY: OREDINNERS SHALL NOT BE LIABLE FOR ANY INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE SOFTWARE, INCLUDING BUT NOT LIMITED TO DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION, OR LOSS OF DATA, EVEN IF OREDINNERS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
                
                    GOVERNING LAW: This EULA will be governed by and construed in accordance with the laws of the State of California, without giving effect to any choice of law or conflict of law provisions.
                
                    ENTIRE AGREEMENT: This EULA constitutes the entire agreement between you and OreDinners with respect to the Software and supersedes all prior or contemporaneous communications and proposals, whether oral or written, between you and OreDinners.
                
                    ACKNOWLEDGMENT: By downloading or using the Software, you acknowledge that you have read this EULA, understand it, and agree to be bound by its terms and conditions.
                
                    CONTACT INFORMATION: If you have any questions about this EULA, please contact OreDinners at ctcramer@mines.edu.
                """)
                        .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
            })
    }
    
    func register() {
        if(checked){
            session.signUp(username: username, email: email, password: password)
        }
        else{
            session.alertMessage = "Please Agree to the EULA"
            session.showAlert = true
        }
       
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}
