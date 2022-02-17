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
    @State var isEditOk = false
    
    var body: some View {
        ZStack {
            CLBackgroundColor()
            ScrollView {
                VStack {
                    Spacer().frame(height: 30)
                    ForEach(usersPersonalDetails) { personDetails in
                        Image(uiImage: UIImage(data: personDetails.profilePicture ?? Data() as Data)!)
                            .resizable()
                            .frame(width: 70, height: 70)
                            .cornerRadius(35)
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
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            isEditOk = false
            dismiss()
        }) {
            Text("Cancel")
                .navigationButtonTextViewModifiers()
        }, trailing: Button(action: {isEditOk = true}) {
            Text("Edit")
                .navigationButtonTextViewModifiers()
        })
        .navigationBarColor(.paleGrey2)
    }
}
