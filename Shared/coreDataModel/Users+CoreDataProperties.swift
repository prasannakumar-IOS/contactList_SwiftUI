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
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profilePicture: Data?
    @NSManaged public var address: String?
    @NSManaged public var dob: Date?
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var gender: String?

}

extension Users : Identifiable {

}
