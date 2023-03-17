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
    
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    @State var caption = ""
    @State var location = ""
    
    @Binding var showCreate : Bool
    @State var showError = false
    @State var showCompletion = false
    
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
                
                if let data = data, let uiimage = UIImage(data: data) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.7, height: screenHeight * 0.3)
                }
                else {
                    
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images, label: {
                        VStack {
                            Image(systemName: "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.3)
                                .border(.white)
                            Text("Select an Image")
                        }
                        
                    })
                    .onChange(of: selectedItems, perform: { newValue in
                        guard let item = selectedItems.first else {
                            return
                        }
                        item.loadTransferable(type: Data.self) {result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    self.data = data
                                }
                                else {
                                    print("Data is nil")
                                }
                            case .failure(let failure):
                                fatalError("\(failure)")
                            }
                        }
                    })
                    
                }
                
                TextFieldView(name: "Location", bindingText: $location, isSecureField: false)
                
                TextFieldView(name: "Caption", bindingText: $caption, isSecureField: false)
                
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
        .alert("Sorry, there was an error making your post!", isPresented: $showError) {
                    Button("OK", role: .cancel) { }
                }
        .alert("Post successfully uploaded!", isPresented: $showCompletion) {
                    Button("OK", role: .cancel) { }
                }
    }
    
    func uploadPost() {
        do {
            try postRepo.submitPost(location: location, caption: caption, imgData: data)
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
