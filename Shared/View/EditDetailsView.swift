//
//  EditDetailsView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 09/03/22.
//

import SwiftUI

struct EditDetailsView: View {
    
    var userEmail: String
    @FetchRequest var usersPersonalDetails: FetchedResults<Users>
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var company = ""
    @State private var phoneNumber = ""
    init(userEmail: String) {
        self.userEmail = userEmail
        _usersPersonalDetails = FetchRequest<Users>(sortDescriptors: [], predicate: NSPredicate(format: "email == %@", userEmail))
        print(usersPersonalDetails)
    }
    
    var body: some View {
        ZStack {
            CLBackgroundColor()
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(usersPersonalDetails) { personDetails in
                        HStack {
                            VStack {
                                Image(uiImage: UIImage(data: personDetails.profilePicture ?? Data()) ?? UIImage())
                                    .resizable()
                                    .frame(width: 62, height: 62)
                                    .cornerRadius(31)
                                Spacer().frame(height: 6.5)
                                Button(action: {}) {
                                    Text("Edit")
                                        .font(.custom("Lato-Regular", size: 11))
                                        .foregroundColor(.darkishPink)
                                }
                            }
                            .frame(width: 115, height: 188)
                            .background(Color.white)
                            Spacer().frame(width: 6)
                            VStack {
                                InputView(text: $firstName, titleText: "First name")
                                Spacer().frame(height: 6)
                                InputView(text: $lastName, titleText: "Last name")
                            }
                        }
                    }
                    InputView(text: $company, titleText: "Company")
                    Spacer().frame(height: 6)
                    InputView(text: $phoneNumber, titleText: "Phone")
                    Spacer().frame(height: 6)
                    
                }.padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            }
            .onAppear(perform: {
                self.firstName = usersPersonalDetails[0].firstName ?? ""
                self.lastName = usersPersonalDetails[0].lastName ?? ""
                self.company = usersPersonalDetails[0].company ?? ""
                self.phoneNumber = usersPersonalDetails[0].phoneNumber ?? ""
            })
        }.textFieldStyle(CLTextFieldStyle())
    }
}
