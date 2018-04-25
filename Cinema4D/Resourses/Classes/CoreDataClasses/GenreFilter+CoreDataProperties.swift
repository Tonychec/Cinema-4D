//
//  GenreFilter+CoreDataProperties.swift
//  Cinema4D
//
//  Created by Nomad on 4/25/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//
//

import Foundation
import CoreData


extension GenreFilter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreFilter> {
        return NSFetchRequest<GenreFilter>(entityName: "GenreFilter")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var isSelected: Bool

}
