//
//  SignUpView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var signupViewModel = SignUpViewModel()
    @State private var isSignInError = false
    @Binding var isSignUpOk: Bool
    @State private var showWebView = false
    let angularGradient = AngularGradient(gradient: Gradient(colors: [.blue, .white, .blue, .white]), center: .center, angle: .degrees(90))

    var body: some View {
        ZStack {
            CLBackgroundColor()
            ScrollView {
                VStack {
                    Spacer().frame(height: 16)
                    HStack {
                        InputView(text: $signupViewModel.firstName, titleText: "First name")
                        InputView(text: $signupViewModel.lastName, titleText: "Last name")
                    }
                    InputView(text: $signupViewModel.company, titleText: "Company")
                    InputView(text: $signupViewModel.email, titleText: "Email")
                    InputView(text: $signupViewModel.phoneNumber, titleText: "Phone")
                    SecureInputView(text: $signupViewModel.passWord, titleText: "Password")
                    SecureInputView(text: $signupViewModel.passWord, titleText: "Confirm password")
                    AddressInputView(titleText: addressInputTitles, streetAddressFirst: $signupViewModel.streetAddressFirst, streetAddressSecond: $signupViewModel.streetAddressSecond, cityAddress: $signupViewModel.cityAddress, stateAddress: $signupViewModel.stateAddress, postalCode: $signupViewModel.postalCode)
                    HStack {
                        Text("Accept the")
                            .foregroundColor(.darkishPink)
                        Link(destination: URL(string: "https://www.mallow-tech.com/")!, label: {
                            Text("Terms & conditions")
                                .underline()
                        })
                    }
                    Button {
                        showWebView = true
                    } label: {
                        Text("Accept the terms & conditions")
                            .foregroundColor(.darkishPink)
                    }
                    .sheet(isPresented: $showWebView) {
                        NavigationView {
                            WebView(url: URL(string: "https://www.mallow-tech.com/")!)
                        }
                    }
                }
                .textFieldStyle(CLTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 19, bottom: 0, trailing: 19))
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("Signup"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                isSignUpOk = false
            }) {
                Text("Cancel")
                    .navigationButtonTextViewModifiers()
            }, trailing: Button(action: {
                if signupViewModel.saveContent() == false {
                    isSignInError = true
                } else {
                    isSignUpOk = false
                }
            }) {
                Text("Save")
                    .navigationButtonTextViewModifiers()
            })
            .alert("Invalid", isPresented: $isSignInError, actions: {
                    Button("OK", role: .cancel) { }
            }, message: {Text("Please enter the valid details :)")})
//            Circle()
//                .fill(angularGradient)
//                .frame(width: 100, height: 100)
        }
    }
    
    func getCoreDataDBPath() {
              let path = FileManager
                  .default
                  .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                  .last?
                  .absoluteString
                  .replacingOccurrences(of: "file://", with: "")
                  .removingPercentEncoding
              print("😀Core Data DB Path :: \(path ?? "Not found")")
          }

}

