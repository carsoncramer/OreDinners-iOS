//
//  alert+Patched.swift
//  OreDinners
//
//  Created by Carson Cramer on 4/10/23.
//

import SwiftUI

extension View {
    public func alertPatched(isPresented: Binding<Bool>, content: () -> Alert) -> some View {
        self.overlay(
            EmptyView().alert(isPresented: isPresented, content: content),
            alignment: .bottomTrailing
        )
    }
}

