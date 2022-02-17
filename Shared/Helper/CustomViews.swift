//
//  customViews.swift
//  ContactList (iOS)
//
//  Created by Prasannakumar Manikandan on 31/01/22.
//

import SwiftUI


struct CLTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .font(.custom("Lato-Semibold", size: 17))
            .frame(height: 40)
            .background(Color.steel12)
            .cornerRadius(5)
            .foregroundColor(.black85)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct InputView: View {
    
    @Binding var text: String
    var titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .titleTextModifiers()
            if titleText == "Username" || titleText == "Email" {
                TextField(titleText, text: $text)
                    .autocapitalization(.none)
                    .padding(.bottom, 20)
            } else {
                TextField(titleText, text: $text)
                    .padding(.bottom, 20)
            }
        }
        .backgroundViewModifiers()
    }
}

struct SecureInputView: View {
    
    @Binding var text: String
    var titleText: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .titleTextModifiers()
            SecureField(titleText, text: $text)
                .autocapitalization(.none)
                .padding(.bottom, 20)
        }
        .backgroundViewModifiers()
    }
}

struct AddressInputView: View {
    
    var titleText: [String]
    @Binding var streetAddressFirst: String
    @Binding var streetAddressSecond: String
    @Binding var cityAddress: String
    @Binding var stateAddress: String
    @Binding var postalCode: String
    
    var body: some View {
        VStack {
            Text("Address")
                .titleTextModifiers()
            TextField(titleText[0], text: $streetAddressFirst)
            Spacer().frame(height: 3)
            TextField(titleText[1], text: $streetAddressSecond)
            Spacer().frame(height: 3)
            TextField(titleText[2], text: $cityAddress)
            Spacer().frame(height: 3)
            TextField(titleText[3], text: $stateAddress)
            Spacer().frame(height: 3)
            TextField(titleText[4], text: $postalCode)
                .padding(.bottom, 20)
        }
        .background(Color.white)
        .cornerRadius(5)
    }
}

struct CLBackgroundColor: View {
    var body: some View {
        Color.paleGrey
            .ignoresSafeArea()
    }
}

struct DisplayUserDataView: View {
    
    var titleText: String
    var userData: String
    
    var body: some View {
        VStack {
            Text(titleText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
                .font(.custom("Lato-Regular", size: 14))
                .foregroundColor(.black85)
            Spacer().frame(height: 1)
            Text(userData)
                .frame(maxWidth: .infinity,minHeight: 22, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 15, trailing: 20))
                .font(.custom("Lato-Regular", size: 18))
                .foregroundColor(.darkishPink)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(5)
        Spacer().frame(height: 6)
    }
}



