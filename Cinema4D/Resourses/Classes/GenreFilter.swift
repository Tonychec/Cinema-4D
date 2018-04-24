//
//  GenreFilter.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class GenreFilter {
    var filmCounter: Int?
    var state: ViewBtn.BtnState
    var title: String
    var id: String
    var action: (() -> ())?
    
    init(title: String, id: String, state: ViewBtn.BtnState, action: (() -> ())?) {
        self.action = action
        self.id = id
        self.state = state
        self.title = title
    }
}
