//
//  Filter.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class Filter {
    var title: String
    var id: String
    var isSelected: Bool
    
    init(title: String, id: String, isSelected: Bool) {
        self.id = id
        self.isSelected = isSelected
        self.title = title
    }
}
