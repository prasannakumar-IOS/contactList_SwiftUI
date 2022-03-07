//
//  PersonDetailsDisplayView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 10/02/22.
//

import SwiftUI

struct PersonDetailsDisplayView: View {
    
    @Environment(\.dismiss) private var dismiss
    var userEmail: String
    @FetchRequest var usersPersonalDetails: FetchedResults<Users>
    init(userEmail: String) {
        self.userEmail = userEmail
        _usersPersonalDetails = FetchRequest<Users>(sortDescriptors: [], predicate: NSPredicate(format: "email == %@", userEmail))
    }
    var userDatas = Users()
    @State private var isEditOk = false
    @EnvironmentObject var appState: AppState
    @State private var userLogInEmail = UserDefaults.standard.string(forKey: "userLogInEmail")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isSharePresented = false
    @StateObject var personDetailsDisplayViewModel = PersonDetailsDisplayViewModel()
    @State var degree = 0.0

    var body: some View {
        ZStack {
            CLBackgroundColor()
            ScrollView {
                VStack {
                    Spacer().frame(height: 30)
                    ForEach(usersPersonalDetails) { personDetails in
                        Image(uiImage: personDetailsDisplayViewModel.loadData(defaultPic: personDetails.profilePicture!))
                            .resizable()
                            .frame(width: 70, height: 70)
                            .cornerRadius(35)
                            .shadow(radius: 2)
                        if let firstName = personDetails.firstName, let lastName = personDetails.lastName {
                            Text(firstName + " " + lastName)
                                .font(.custom("Lato-Regular", size: 18))
                                .foregroundColor(.black85)
                        }
                        Text(personDetails.company ?? "")
                            .font(.custom("Lato-Regular", size: 11))
                            .foregroundColor(.brownishGrey)
                        Spacer().frame(height: 30)
                        DisplayUserDataView(titleText: "phone", userData: personDetails.phoneNumber ?? "")
                        DisplayUserDataView(titleText: "email", userData: personDetails.email ?? "")
                        let userAddress = personDetails.address?.replacingOccurrences(of: "|", with: "\n")
                        DisplayUserDataView(titleText: "address", userData: userAddress ?? "")
                        Group {
                            Button(action: {}) {
                                Text("View Social Profile")
                                    .font(.custom("Lato-Regular", size: 18))
                                    .foregroundColor(.darkishPink)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color.white)
                        .shadow(color: .black7, radius: 1, x: 0, y: 3)
                        Spacer().frame(height: 40)
                        if userEmail == userLogInEmail {
                            Button(action: {
                                appState.goToLogIn = true
                            }) {
                                Text("Log Out")
                                    .foregroundColor(.white)
                                    .font(.custom("Lato-Semibold", size: 17))
                                    .frame(maxWidth: .infinity, minHeight: 50)
                            }
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.darkishPink)
                            .cornerRadius(5)
                        }
                    }
                    Button(action: {
                        isSharePresented = true
                    }) {
                        Text("Share")
                            .foregroundColor(.white)
                            .font(.custom("Lato-Semibold", size: 17))
                            .frame(maxWidth: .infinity, minHeight: 50)
                    }.sheet(isPresented: $isSharePresented, onDismiss: {
                        print("Dismiss")
                    }, content: {
                        ActivityController(activityItems: [userEmail as AnyObject])
                    })
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.darkishPink)
                    .cornerRadius(5)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .onReceive(self.appState.$goToLogIn) { goToLogIn in
            if goToLogIn {
                dismiss()
            }
        }
        .navigationBarItems(trailing: Button(action: {isEditOk = true}) {
            Text("Edit")
                .navigationButtonTextViewModifiers()
        })
        .navigationBarColor(.paleGrey2)
    }
}
