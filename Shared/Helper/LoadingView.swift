//
//  ActivityIndicatorView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 03/03/22.
//

import SwiftUI


struct LoadingView: View {

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
                .opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(2)
        }
    }
}
