//
//  PersistenceManager.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 14/02/22.
//

import CoreData
import SwiftUI

struct PersistenceManager {
    static let shared = PersistenceManager()

    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {

        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ContactList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveData(userDatas: [Any]) {
        let userInfo = Users(context: container.viewContext)
        userInfo.firstName = userDatas[0] as? String
        userInfo.lastName = userDatas[1] as? String
        userInfo.company = userDatas[2] as? String
        userInfo.password = userDatas[3] as? String
        userInfo.id = UUID().uuidString
        userInfo.address = userDatas[4] as? String
        userInfo.email = userDatas[5] as? String
        userInfo.profilePicture = userDatas[6] as? Data
        userInfo.phoneNumber = userDatas[7] as? String
        if saveContext() {
//
        } else {
//
        }
    }
    
    func saveContext() -> Bool {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        return true
    }
    
    func fetchUserForLogin(userMail: String) -> [Users] {
        let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
        let predicate = NSPredicate(format: "email = %@", userMail)
        fetchRequest.predicate = predicate
        let result = (try? container.viewContext.fetch(fetchRequest)) ?? []
        return result
        }
    }
