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
    
    func saveData(userDatas: [AllUsers]) {
        for user in userDatas {
            if isDuplicateUser(email: user.email ?? "") {
                let users = Users(context: container.viewContext)
                users.firstName = user.firstName
                users.lastName = user.lastName
                users.company = user.firstName
                users.id = user.id ?? 1
                users.email = user.email
                users.address = user.address
                users.phoneNumber = user.phoneNumber
                users.createdAt = user.createdAt
                users.dob = user.dob
                users.profilePicture = Data(setProfilePic(firstName: String(user.firstName?.first ?? "N"), lastName: String(user.lastName?.first ?? "N")))
                users.updatedAt = user.updatedAt
                users.gender = user.gender
            }
        }
        let _ = saveContext()
    }
    
    func setProfilePic(firstName: String, lastName: String) -> NSData {
        let nameInitialize = UILabel()
        nameInitialize.frame.size = CGSize(width: 50.0, height: 50.0)
        nameInitialize.textColor = UIColor.black25
        nameInitialize.text = firstName + lastName
        nameInitialize.textAlignment = NSTextAlignment.center
        nameInitialize.backgroundColor = UIColor.paleGrey2
        nameInitialize.layer.cornerRadius = 50.0
        UIGraphicsBeginImageContext(nameInitialize.frame.size)
        nameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        let picture = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let pictureData: NSData = picture.pngData()! as NSData
        return pictureData
    }
    
    func isDuplicateUser(email: String) -> Bool {
        let emailTrim = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "\("email") = %@", emailTrim)
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            if result.count == 0 {
                return true
            } else {
                return false
            }
        } catch {
            return true
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
