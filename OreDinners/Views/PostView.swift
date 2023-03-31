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
    @State var showError = false

    
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
                        
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundColor(Color("MinesBlue"))
            VStack{
                HStack{
                    Text(PostVM.post.username)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .padding(.top)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 5, height: 5)
                        .padding(.top)
                    Text(PostVM.timeSince)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .regular, design: .serif))
                        .italic()
                        .padding(.top)
                    Spacer()
                    if PostVM.post.isOwner {
                        HStack {
                            Spacer()
                            Button(action: {delete()}, label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .regular, design: .serif))
                            })
                            .buttonStyle(BorderlessButtonStyle())
                            .padding()
                        }
                    }
                }
                .padding(.horizontal)
        
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
                    Image(systemName: "building.2")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                    Text(PostVM.post.location)
                        .foregroundColor(.black)
                        .italic()
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(alignment: .top){
                    Image(systemName: "message")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
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
        .alert("Network error while deleting your post", isPresented: $showError) {
                    Button("OK", role: .cancel) { }
                }
        //.frame(height: screenHeight * 0.6)
    }
    
    func delete(){
        do {
            try postRepo.deletePost(post: PostVM.post)
        }
        catch _ {
            showError = true
        }
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

