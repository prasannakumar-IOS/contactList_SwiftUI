//
//  ContactListViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI
import Combine

class ContactListViewModel: ObservableObject {
    
    @Published var userContactList: [AllUsers] = []
    @Published var pageNumber: Int = 121
    @Published var isLoading: Bool = false
    
    var cancelToken: AnyCancellable?
    
    func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.paleGrey2
        UINavigationBar.appearance().standardAppearance = appearance;
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }
    
    func makeAttributedString(firstName: String, lastName: String, searchName: String) -> AttributedString {
        var string = AttributedString(firstName + " " + lastName)
        string.font = .custom("Lato-Regular", size: 18)
        string.foregroundColor = .black85
        if let range = string.range(of: searchName) {
            string[range].font = .custom("Lato-Bold", size: 18)
        } else if let range = string.range(of: firstName) {
            string[range].font = .custom("Lato-Bold", size: 18)
        }
        return string
    }
    
    func getContactList() {
        isLoading = true
        cancelToken =  UserManager.shared.getUserDetails(url: URL(string: "\(APIUrlCalls.getAllUser.urlString)?page=\(pageNumber)")!).sink(receiveCompletion: { _ in }, receiveValue: { response in
            if response.error != nil {
                print(response.error)
                print(response)
                print("Error")
                self.isLoading = false
            } else if let data = response.data {
                do {
                    let value = try JSONDecoder().decode(AllUsersDetails.self, from: data)
                    if let users = value.allUsers {
                        self.userContactList.append(contentsOf: users)
                        PersistenceManager.shared.saveData(userDatas: self.userContactList)
                        self.isLoading = false
                    }
                } catch {
                    
                }
            }
        })
        
    }
}

