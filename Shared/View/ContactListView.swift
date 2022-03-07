//
//  ContactListView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

struct ContactListView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var searchName = ""
    @EnvironmentObject var appState: AppState
    @Binding var isContactList: Bool
    var contactListViewModel = ContactListViewModel()
    
    var body: some View {
        
        ZStack {
            CLBackgroundColor()
            List {
                ContactListCellView(searchName: $searchName)
                    .padding(.horizontal, 14)
                    .background(Color.white)
            }
            .refreshable {
                dismiss()
            }
            .listStyle(.plain)
            .searchable(text: $searchName, placement: .navigationBarDrawer(displayMode: .always)) {
                
            }.autocapitalization(.none)
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
            .onReceive(self.appState.$goToLogIn) { goToLogIn in
                if goToLogIn {
                    isContactList = false
                }
            }
        }
 

    }
}

//
//struct ContactListView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ContactListView(isContactList: .constant(true))
//    }
//}
