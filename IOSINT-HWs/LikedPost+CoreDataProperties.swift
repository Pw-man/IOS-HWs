//
//  LikedPost+CoreDataProperties.swift
//  
//
//  Created by Роман on 30.01.2022.
//
//

import Foundation
import CoreData


extension LikedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPost> {
        return NSFetchRequest<LikedPost>(entityName: "LikedPost")
    }

    @NSManaged public var author: String?
    @NSManaged public var views: Int32
    @NSManaged public var likes: Int32
    @NSManaged public var postDescription: String?
    @NSManaged public var image: String?

}
