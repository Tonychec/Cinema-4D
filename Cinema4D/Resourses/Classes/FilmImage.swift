//
//  FilmImage.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class FilmImage {
    var id: String
    var url: String
    var data: Data?
    
    init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}
