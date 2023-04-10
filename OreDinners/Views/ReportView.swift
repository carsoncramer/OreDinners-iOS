//
//  ReportView.swift
//  OreDinners
//
//  Created by Carson Cramer on 4/8/23.
//

import SwiftUI
import Firebase

struct ReportView: View {
    
    @EnvironmentObject var postRepo : PostRepository
    @EnvironmentObject var session : SessionStore
    
    @Binding var showReport : Bool
    @State var showConfirmReportAlert = false
    @State var showConfirmBlockAlert = false
    @State var showSuccessAlert = false
    @State var postReported : Post
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("MinesBlue"))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Report Post or Block User")
                    .foregroundColor(.white)
                    .font(.title)
                Text("If a post is offensive or a user is spamming, please report or block them. We will review the report within 24 hours of being submitted.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {showConfirmReportAlert.toggle()}, label: {
                    Text("Report Post")
                        .padding()
                        .background(Color("MinesRed"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                })
                Button(action: {showConfirmBlockAlert.toggle()}, label: {
                    Text("Block \"\(postReported.username)\"")
                        .padding()
                        .background(Color("MinesRed"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                })
                Spacer()
            }
        }
        .alertPatched(isPresented: $showConfirmBlockAlert, content: {
            Alert(
                title: Text("Are you sure you want to block \(postReported.username)?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Block")) {
                    session.blockUser(uid: postReported.userID)
                    showSuccessAlert.toggle()
                },
                secondaryButton: .cancel()
            )
        })
        .alertPatched(isPresented: $showConfirmReportAlert) {
            Alert(
                title: Text("Are you sure you want to report this post?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Report")) {
                    postRepo.reportPost(post: postReported)
                    showSuccessAlert.toggle()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(showReport: .constant(true), postReported: Post(id: "1234567890", location: "Something offensive", time: Timestamp(), image: "bad image", userID: "wjn2ljkbf3r341jkn", username: "Racist", caption: "I am a bad person", isOwner: false))
    }
}
