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
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    Text(ProfileVM.username)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.leading)
                HStack{
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    Text(ProfileVM.email)
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
            }
            .alert("Something went wrong. Please restart the app", isPresented: $session.showError) {
                        Button("OK", role: .cancel) { }
                    }
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
