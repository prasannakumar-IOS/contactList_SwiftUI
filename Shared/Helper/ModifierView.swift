//
//  ModifierView.swift
//  ContactList (iOS)
//
//  Created by Prasannakumar Manikandan on 07/02/22.
//

import SwiftUI

struct titleTextModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.darkishPink)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.custom("Lato-Regular", size: 15))
            .padding(EdgeInsets(top: 21, leading: 15, bottom: 0, trailing: 15))
    }
}

struct backgroundViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 91)
            .background(Color.white)
            .cornerRadius(5)
    }
}

struct navigationButtonTextViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Lato-Regular", size: 17))
            .foregroundColor(.darkishPink)
    }
}

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    func titleTextModifiers() -> some View {
        modifier(titleTextModifier())
    }
    
    func backgroundViewModifiers() -> some View {
        modifier(backgroundViewModifier())
    }
    
    func navigationButtonTextViewModifiers() -> some View {
        modifier(navigationButtonTextViewModifier())
    }
    
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
           self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
       }
}
