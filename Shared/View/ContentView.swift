//
//  ContentView.swift
//  Shared
//
//  Created by Prasannakumar Manikandan on 31/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userName = ""
    @State private var passWord = ""
    @State private var isSignUpOk = false
    @State private var userLogInEmailWrong = false
    @State private var userLogInPasswordWrong = false
    @State private var isContactListOk = false
    @EnvironmentObject var usersDetails: SignUpViewModel
    var logInViewModel = LogInViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.paleGrey
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 85, height: 85)
                            .padding(EdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0))
                        inputView(text: $userName, titleText: "Username")
                            .padding(.bottom, 0)
                        secureInputView(text: $passWord, titleText: "Password")
                            .padding(.bottom, 10)
                        NavigationLink(destination: ContactListView(), isActive: $isContactListOk) {
                            Button(action: {
                                let validUser = logInViewModel.checkLoginUser(email: userName, password: passWord, personDetails: usersDetails.personDetails)
                                if validUser == 0, userName != "", passWord != "" {
                                    isContactListOk = true
                                } else if validUser == 1 {
                                    userLogInPasswordWrong = true
                                } else {
                                    userLogInEmailWrong = true
                                }
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
                        NavigationLink(destination: SignUpView(isSignUpOk: $isSignUpOk), isActive: $isSignUpOk) {
                            Button(action: {
                               isSignUpOk = true
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
                    .alert("Invalid", isPresented: $userLogInEmailWrong, actions: {
                            Button("OK", role: .cancel) { }
                    }, message: {Text("Please register your email ID")})
                    .alert("Invalid", isPresented: $userLogInPasswordWrong, actions: {
                            Button("OK", role: .cancel) { }
                    }, message: {Text("Invalid password, Please enter the valid password!")})
                    .textFieldStyle(CLTextFieldStyle())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .navigationBarHidden(true)
        }
    }
}

