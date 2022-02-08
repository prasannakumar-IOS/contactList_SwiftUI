//
//  ContactListView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

struct ContactListView: View {
    
    @EnvironmentObject var usersDetails: SignUpViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.paleGrey
                .ignoresSafeArea()
            List {
                ForEach(0..<usersDetails.personDetails.count, id: \.self) { userIndex in
                    HStack {
                        Image(uiImage: UIImage(data: usersDetails.personDetails[userIndex].profilePicture as Data)!)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                        Spacer().frame(width: 10)
                        Text(usersDetails.personDetails[userIndex].name)
                            .font(.custom("Lato-Bold", size: 18))
                            .foregroundColor(Color.black85)
                        Spacer()
                        Button(action: {}) {
                            Text("Follow")
                                .navigationButtonTextViewModifiers()
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .background(Color.white)
                    .frame(height: 70)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .refreshable {
                dismiss()
            }
            .listStyle(.grouped)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text("Contacts"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {}) {
                Text("Groups")
                    .navigationButtonTextViewModifiers()
            }, trailing: Button(action: {}) {
                Image("iconAdd")
                    .resizable()
                    .frame(width: 24, height: 24)
            })
            .navigationBarColor(.paleGrey2)
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
