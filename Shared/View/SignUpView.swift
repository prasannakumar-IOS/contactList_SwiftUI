//
//  SignUpView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var usersDetails: SignUpViewModel
    @Binding var isSignUpOk: Bool
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var company: String = ""
    @State private var phoneNumber: String = ""
    @State private var passWord: String = ""
    @State private var streetAddressFirst: String = ""
    @State private var streetAddressSecond: String = ""
    @State private var cityAddress: String = ""
    @State private var stateAddress: String = ""
    @State private var postalCode: String = ""
    
    var body: some View {
        ZStack {
            Color.paleGrey
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Spacer().frame(height: 16)
                    HStack {
                        inputView(text: $firstName, titleText: "First name")
                        inputView(text: $lastName, titleText: "Last name")
                    }
                    inputView(text: $company, titleText: "Company")
                    inputView(text: $email, titleText: "Email")
                    inputView(text: $phoneNumber, titleText: "Phone")
                    secureInputView(text: $passWord, titleText: "Password")
                    secureInputView(text: $passWord, titleText: "Confirm password")
                    addressInputView(titleText: ["Street", "Street", "City", "State", "Postal code"], streetAddressFirst: $streetAddressFirst, streetAddressSecond: $streetAddressSecond, cityAddress: $cityAddress, stateAddress: $stateAddress, postalCode: $postalCode)
                }
                .textFieldStyle(CLTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 19, bottom: 0, trailing: 19))
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("Signup"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {isSignUpOk = false}) {
                Text("Cancel")
                    .navigationButtonTextViewModifiers()
            }, trailing: Button(action: {
                usersDetails.personDetails.append(userDetails(email: email, name: firstName + " " + lastName, company: company, phoneNumber: phoneNumber, passWord: passWord, address: streetAddressFirst + "|" + streetAddressSecond + "|" + cityAddress + "|" + stateAddress + "|" + postalCode, profilePicture: usersDetails.SetProfilePic(firstName: String(firstName.first!), lastName: String(lastName.first!))))
                isSignUpOk = false
            }) {
                Text("Save")
                    .navigationButtonTextViewModifiers()
            })
        }
    }
}

