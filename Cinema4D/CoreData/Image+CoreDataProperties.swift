//
//  Image+CoreDataProperties.swift
//  
//
//  Created by Nomad on 4/24/18.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var data: NSData?
    @NSManaged public var id: String?

}
