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
    
    var body: some View {
        ZStack {
            CLBackgroundColor()
            List {
                ContactListCellView()
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
            }
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
            //   .navigationBarColor(.paleGrey2)
        }
    }
}

