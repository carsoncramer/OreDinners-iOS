//
//  NeedsUpdateView.swift
//  OreDinners
//
//  Created by Carson Cramer on 3/31/23.
//

import SwiftUI

struct NeedsUpdateView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Text("🥳")
                Text("We released an update! \nPlease update the app via the app store.")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .padding()

        }
        
    }
}

struct NeedsUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        NeedsUpdateView()
    }
}
