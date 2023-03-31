//
//  CreatePostView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/14/23.
//

import SwiftUI
import PhotosUI

struct CreatePostView: View {
    
    @EnvironmentObject var postRepo : PostRepository
    
    @State var image = UIImage()
    
    @State var caption = ""
    @State var location = ""
    
    @Binding var showCreate : Bool
    @State var showError = false
    @State var showCompletion = false
    @State var showImageLibrary = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("MinesBlue"))
            
            VStack() {
                Text("Create Post")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)
                
                Button(action: {showImageLibrary.toggle()}, label: {
                    VStack {
                        Image(uiImage: self.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth * 0.95, height: screenWidth * 0.95)
                            .border(.white)
                        
                        Text("Select an Image")
                    }
                })
        
                TextFieldView(name: "Location", bindingText: $location, isSecureField: false, maxLen: 50)
                
                TextFieldView(name: "Caption", bindingText: $caption, isSecureField: false, maxLen: 250)
                
                HStack {
                    Button(action: {showCreate.toggle()}, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: screenWidth * 0.2, height: screenWidth * 0.1)
                                .foregroundColor(.red)
                            Text("Delete")
                                .foregroundColor(.white)
                        }
                    })
                    .padding()
                    Button(action: {uploadPost()}, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: screenWidth * 0.2, height: screenWidth * 0.1)
                                .foregroundColor(.green)
                            Text("Post")
                                .foregroundColor(.white)
                        }
                    })
                    .padding()
                }
                Spacer()
                
            }
        }
        .sheet(isPresented: $showImageLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .alert("Sorry, there was an error making your post!", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        }
        .alert("Post successfully uploaded!", isPresented: $showCompletion) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func uploadPost() {
        do {
            try postRepo.submitPost(location: location, caption: caption, uiimage: image)
            showCreate.toggle()
            showCompletion.toggle()
        }
        catch _ {
            showError.toggle()
        }
    }
    
    
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(showCreate: .constant(true)).environmentObject(SessionStore())
    }
}
