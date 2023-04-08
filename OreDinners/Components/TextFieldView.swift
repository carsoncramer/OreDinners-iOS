//
//  TextFieldView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/8/23.
//

import SwiftUI

struct TextFieldView: View {
    @State var name : String
    @Binding var bindingText : String
    @State var isSecureField : Bool
    @State var maxLen : Int
    var body: some View {
        VStack {
            if isSecureField {
                SecureField(name, text: $bindingText)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
//                    .placeholder(when: bindingText.isEmpty, placeholder: {
//                        Text(name)
//                            .foregroundColor(.white)
//                            .textFieldStyle(.plain)
//                            .bold()
//                    })
                    .padding(.horizontal)
                    .padding(.top)
                    .onChange(of: bindingText, perform: {
                              bindingText = String($0.prefix(maxLen))
                            })
                    .textInputAutocapitalization(.none)
            }
            else{
                TextField(name, text: $bindingText)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
//                    .placeholder(when: bindingText.isEmpty, placeholder: {
//                        Text(name)
//                            .foregroundColor(.white)
//                            .bold()
//                    })
                    .padding(.horizontal)
                    .padding(.top)
                    .onChange(of: bindingText, perform: {
                              bindingText = String($0.prefix(maxLen))
                            })
                    
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            TextFieldView(name: "password", bindingText: .constant("hello there"), isSecureField: true, maxLen: 40)
        }
    }
}
