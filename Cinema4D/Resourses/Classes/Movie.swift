//
//  Movie.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class Movie {
    var addDate: NSDate?
    var isFavorite = false
    var releaseDate: String
    var tagline: String
    var title: String
    var imageId: String
    var genres: [Int]
    var userMark: String?
    var description: String?
    
    init(releaseDate: String, tagline: String, title: String, imageId: String, genres: [Int]) {
        self.releaseDate = releaseDate
        self.title = title
        self.tagline = tagline
        self.imageId = imageId
        self.genres = genres
    }
}
