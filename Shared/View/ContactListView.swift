//
//  ContactListView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

struct ContactListView: View {
    
    @State private var searchName = ""
    @EnvironmentObject var appState: AppState
    @Binding var isContactList: Bool
    @StateObject var contactListViewModel = ContactListViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
//        NavigationView {
            ZStack {
                CLBackgroundColor()
                List {
                    ContactListCellView(searchName: $searchName)
                        .padding(.horizontal, 14)
                        .background(Color.white)
                }
                .refreshable {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                }
                .onAppear(perform: {
                    contactListViewModel.getContactList()
                })
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
//                            isContactList = false
                        }
                    }
                    .onAppear(perform: {
//                        presentationMode.wrappedValue.dismiss()
                    })
                if contactListViewModel.isLoading {
                    LoadingView()
                }
                
//            }
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
