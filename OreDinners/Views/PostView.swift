//
//  PostView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI
import Firebase

struct PostView: View {
    
    @ObservedObject var PostVM : PostViewModel
    @EnvironmentObject var postRepo : PostRepository
    
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
                        
            VStack{
                HStack{
                    Text(PostVM.post.username)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 5, height: 5)
                    Text(PostVM.timeSince)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .regular, design: .serif))
                        .italic()
                    Spacer()
                    if PostVM.post.isOwner {
                        Button(action: {delete()}, label: {
                            Text("🗑️")
                        })
                    }
                }
                .padding(.horizontal)
                .padding(.top
                )
        
                AsyncImage(url: URL(string: PostVM.post.image), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth)
                }, placeholder: {
                    Text("Loading Image...")
                        .foregroundColor(.black)
                })
                .foregroundColor(.white)
                    
                    
                HStack{
                    Text("📍")
                    Text(PostVM.post.location)
                        .foregroundColor(.black)
                        .italic()
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(alignment: .top){
                    Text("📣")
                    Text(PostVM.post.caption)
                        .foregroundColor(.black)
                        .italic()
                        .fixedSize(horizontal: false, vertical: false)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                
                Spacer()
            }
            
        }
    }
    
    func delete(){
        postRepo.deletePost(post: PostVM.post)
    }
    
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("MinesGrey")
            PostView(PostVM: PostViewModel(post: Post(id: "4", location: "SAE Fraternity House", time: Timestamp(), image: "https://firebasestorage.googleapis.com:443/v0/b/oredinners-98d11.appspot.com/o/images%2F9E7B6B75-0472-4417-BDA7-85735219AF36?alt=media&token=6b127063-0ca8-4e70-83d6-fe32798c9c46", userID: "66", username: "123456789012345", caption: "Come get free food from the SAE Rush starting today at 5pm! Meet people and have a great time!!", isOwner: true))).environmentObject(SessionStore())
        }
    }
}

