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
    var body: some View {
        VStack {
            if isSecureField {
                SecureField(name, text: $bindingText)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: bindingText.isEmpty, placeholder: {
                        Text(name)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .bold()
                    })
                    .padding(.horizontal)
                    .padding(.top)
            }
            else{
                TextField(name, text: $bindingText)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: bindingText.isEmpty, placeholder: {
                        Text(name)
                            .foregroundColor(.white)
                            .bold()
                    })
                    .padding(.horizontal)
                    .padding(.top)
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
            TextFieldView(name: "password", bindingText: .constant("hello there"), isSecureField: true)
        }
    }
}
