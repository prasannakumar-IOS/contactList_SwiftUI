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
            }
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .refreshable {
                dismiss()
            }
            .listStyle(.grouped)
            .searchable(text: $searchName, placement: .navigationBarDrawer(displayMode: .always)) {
                let _ = print("😀\(searchName)")
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
            .toolbar {
                EditButton()
            }
//            .onAppear( perform: {
//                contactListViewModel.customizeNavigationBar()
//            })
            .onReceive(self.appState.$goToLogIn) { goToLogIn in
                if goToLogIn {
                    isContactList = false
                }
            }
        }
 

    }
}

