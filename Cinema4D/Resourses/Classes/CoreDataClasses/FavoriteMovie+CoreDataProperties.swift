//
//  FavoriteMovie+CoreDataProperties.swift
//  Cinema4D
//
//  Created by Nomad on 4/25/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var addDate: NSDate?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var releaseDate: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var imageId: String?
    @NSManaged public var userMark: String?
    @NSManaged public var id: String?

}
