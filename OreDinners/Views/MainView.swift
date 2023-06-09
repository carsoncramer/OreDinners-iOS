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
                    .padding(.top)
                //Spacer()
                if postRepo.posts.count > 0 {
                    
                    List {
                        ForEach(postRepo.posts.sorted(by: {$0.time.compare($1.time).rawValue > 0}), id: \.id) { post in
                            PostView(PostVM: PostViewModel(post: post)).listRowBackground(Color.white)
                                .listRowInsets(EdgeInsets())
                        }
                    }.listStyle(PlainListStyle())
                }
                else {
                    Image("SadGirl")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Text("There's no free food right now, make sure to have notifications on to be alerted when someone posts!")
                        .foregroundColor(.black)
                    
                }
                Spacer()
            }
            .padding(.top)
        }
        .sheet(isPresented: self.$showProfile, content: {ProfileView(ProfileVM: ProfileViewModel(), showProfile: $showProfile)})
        .sheet(isPresented: self.$showCreate, content: { CreatePostView(showCreate: $showCreate)})
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PostRepository())
    }
}
