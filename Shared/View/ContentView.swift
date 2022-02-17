//
//  ContentView.swift
//  Shared
//
//  Created by Prasannakumar Manikandan on 31/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var logInViewModel = LogInViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                CLBackgroundColor()
                ScrollView {
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 85, height: 85)
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                        InputView(text: $logInViewModel.userName, titleText: "Username")
                            .padding(.bottom, 0)
                        SecureInputView(text: $logInViewModel.passWord, titleText: "Password")
                            .padding(.bottom, 10)
                        NavigationLink(destination: ContactListView(), isActive: $logInViewModel.isContactListOk) {
                            Button(action: {
                                logInViewModel.fetchRequest()
                            }) {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .font(.custom("Lato-Semibold", size: 17))
                                    .frame(maxWidth: .infinity, minHeight: 50)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.darkishPink)
                        .cornerRadius(5)
                        Spacer().frame(height: 58)
                        Button(action: {}) {
                            Text("Forgot password?")
                                .navigationButtonTextViewModifiers()
                        }
                        Spacer().frame(height: 29)
                        NavigationLink(destination: SignUpView(isSignUpOk: $logInViewModel.isSignUpOk), isActive: $logInViewModel.isSignUpOk) {
                            Button(action: {
                                logInViewModel.isSignUpOk = true
                            }) {
                                Text("Signup")
                                    .navigationButtonTextViewModifiers()
                            }
                        }
                        Spacer().frame(height: 220)
                        Text("version 1.2")
                            .font(.custom("Lato-Regular", size: 10))
                            .foregroundColor(.darkishPink)
                    }
                    .alert("Invalid", isPresented: $logInViewModel.userLogInEmailWrong, actions: {
                        Button("OK", role: .cancel) { logInViewModel.userLogInEmailWrong = false }
                    }, message: {Text("Please register your email ID :)")})
                    .alert("Invalid", isPresented: $logInViewModel.userLogInPasswordWrong, actions: {
                            Button("OK", role: .cancel) { logInViewModel.userLogInPasswordWrong = false }
                    }, message: {Text("Invalid password, Please enter the valid password :)")})
                    .textFieldStyle(CLTextFieldStyle())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .navigationBarHidden(true)
        }
    }

}

