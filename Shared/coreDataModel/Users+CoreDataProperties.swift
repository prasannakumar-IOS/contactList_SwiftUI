//
//  Users+CoreDataProperties.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 14/02/22.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var address: String?

}

extension Users : Identifiable {

}
