//
//  OnboardingView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/28/23.
//

import SwiftUI

var totalPages = 4

struct OnboardingView: View {
    
    @State var currentPage = 1
    @EnvironmentObject var session : SessionStore
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack {
                HStack{
                    
                    Button(action: {
                        if currentPage > 1 {
                            currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal)
                    Spacer()
                }
                Spacer()
                
                if currentPage == 1 {
                    OnboardScreenView(title: "Welcome to OreDinners!",
                                      caption: "We are so happy to have you!",
                                      image: "FamilyWithFood")
                    .transition(.scale)
                }
                if currentPage == 2 {
                    OnboardScreenView(title: "Our Mission",
                                      caption: "We want to connect people through free food on campus.",
                                      image: "RaisingFoodInAir")
                    .transition(.scale)
                }
                if currentPage == 3 {
                    OnboardScreenView(title: "How does it work?",
                                      caption: "Snap a pic of free food, add location and caption, post it!",
                                      image: "GuyOnBurger")
                    .transition(.scale)
                }
                if currentPage == 4 {
                    OnboardScreenView(title: "Be Nice",
                                      caption: "Remember, this is built by students for students.",
                                      image: "PeopleEnjoyingFood")
                    .transition(.scale)
                }
                
                Button(action: {
                    if currentPage < totalPages {
                        currentPage += 1
                    }
                    else {
                        session.firstAppLaunch = false
                    }
                    
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color("MinesBlue"))
                        .clipShape(Circle())
                        .overlay(
                            ZStack{
                                Circle()
                                    .stroke(Color.black.opacity(0.04), lineWidth: 4)
                                
                                Circle()
                                    .trim(from: 0, to: 0.25 * CGFloat(currentPage))
                                    .stroke(Color("MinesBlue"), lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                            }
                                .padding(-15)
                        )
                })
                .padding()
            }
        }
        
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(SessionStore())
    }
}

struct OnboardScreenView: View {
    
    var title : String
    var caption : String
    var image : String
    
    
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                
                Spacer()
            }
        }
    }
}
