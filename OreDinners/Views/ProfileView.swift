//
//  ProfileView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/13/23.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @ObservedObject var ProfileVM : ProfileViewModel
    @Binding var showProfile : Bool
    @EnvironmentObject var session : SessionStore
    @State var showAccountDeletionAlert = false
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("MinesBlue"))
            
            VStack {
                
                Text("Profile")
                    .font(.system(size: 40))
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                HStack{
                    
                    Text("👤 " + ProfileVM.username)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading)
                HStack{
                    Text("📫 " + ProfileVM.email)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading)
                HStack {
                    Button(action: {signOut()}, label: {
                        Text("Sign out")
                            .font(.system(size: 20))
                    })
                    .padding(.top)
                    Spacer()
                    Button(action: {showProfile.toggle()}, label: {
                        HStack {
                            Text("Close")
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    })
                    .padding(.top)
                }
                .padding(.horizontal)
                Spacer()
                Text("Need help? Send an email to ctcramer@mines.edu")
                    .foregroundColor(.white)
                Button(action: {showAccountDeletionAlert.toggle()}, label: {
                    Text("Delete Account")
                        .padding(5)
                        .background(Color("MinesRed"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                })
                Spacer()
                Text("Onboarding images retrieved from Freepik")
                    .foregroundColor(.white)
                    .padding(.bottom)
            }
        }
        .alert(isPresented: $showAccountDeletionAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete your account?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Delete")) {
                            session.deleteAccount()
                        },
                        secondaryButton: .cancel()
                    )
                }
    }
    
    func signOut() {
        session.signOut()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(ProfileVM: ProfileViewModel(), showProfile: .constant(true)).environmentObject(SessionStore())
    }
}
