//
//  ContactListCellView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI

struct ContactListCellView: View {
    
    @FetchRequest(entity: Users.entity(), sortDescriptors: [])
    var usersPersonalDetails: FetchedResults<Users>
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var searchName: String
    var contactListViewModel = ContactListViewModel()
    
    var body: some View {
        ForEach(filterTheNames(), id: \.self) { user in
            if let user = user {
                HStack {
                    Image(uiImage: UIImage(data: (user.profilePicture ?? Data()) as Data)!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                    Spacer().frame(width: 10)
                    if let firstName = user.firstName, let lastName = user.lastName {
                        Text(contactListViewModel.makeAttributedString(firstName: firstName, lastName: lastName, searchName: searchName))
                    }
                    Spacer()
                    Button(action: {}) {
                        Text("Follow")
                            .navigationButtonTextViewModifiers()
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .background(NavigationLink("", destination: PersonDetailsDisplayView(userEmail: user.email ?? "")).opacity(0))
                .frame(height: 70)
                .background(Color.white)
                .listRowSeparator(.hidden)
            }
        }.listRowBackground(Color.paleGrey)
    }
    
    func filterTheNames() -> [FetchedResults<Users>.Element] {
        return usersPersonalDetails.filter {
            var result = false
            if searchName == "" {
                return true
            } else {
                if let firstName = $0.firstName, let lastName = $0.lastName {
                    result = (firstName + " " + lastName).contains(searchName) as? Bool ?? false
                }
                return result
            }
        }
    }
}

