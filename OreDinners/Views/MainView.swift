//
//  MainView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var postRepo : PostRepository
    
    @State var showProfile = false
    @State var showCreate = false
    @State var showError = false
    
    var body: some View {
        ZStack{
            
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {showCreate.toggle()}, label: {
                        Image(systemName: "plus.square")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .padding(.leading)
                    })
                    Spacer()
                    Text("OreDinners")
                        .foregroundColor(.black)
                        .font(.custom("Playball", size: 40))
                    
                    Spacer()
                    Button(action: {showProfile.toggle()}, label: {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    })
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.top)
                Spacer()
                if postRepo.posts.count > 0 {
                    List(postRepo.posts.sorted(by: {$0.time.compare($1.time).rawValue > 0}), id: \.id) { post in //TODO: sort these by creation time
                        PostView(PostVM: PostViewModel(post: post)).listRowBackground(Color.white)
                    }
                    .listStyle(PlainListStyle())
                }
                else {
                    Text("There's no free food right now, make sure to have notifications on to be alerted when someone posts!")
                }
                
                
            }
            .padding(.top)
            .blur(radius: showProfile || showCreate ? 5 : 0)
            .animation(.easeInOut, value: showProfile || showCreate)
            .allowsHitTesting(!(showProfile || showCreate))
            
            if showProfile {
                ProfileView(ProfileVM: ProfileViewModel(), showProfile: $showProfile)
                    .frame(height: screenHeight * 0.3)
                    .padding(.horizontal)
                    .animation(.easeInOut, value: showProfile)
                    .transition(.opacity)
            }
            else if showCreate {
                CreatePostView(showCreate: $showCreate)
                    .frame(height: screenHeight * 0.6)
                    .animation(.easeInOut, value: showProfile)
                    .transition(.opacity)
            }
        }
        .alert("Network error while fetching posts", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
