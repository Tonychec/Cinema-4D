//
//  GenreSingleton.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class GenreSingleton {
    static let sharedInstance = GenreSingleton()
    var genres = [GenreFilter]()
    
    private init() {
        genres.append(GenreFilter(title: "Thriller", id: "", state: .normal, action: nil))
        genres.append(GenreFilter(title: "Action", id: "", state: .normal, action: nil))
        genres.append(GenreFilter(title: "Comedy", id: "", state: .normal, action: nil))
    }
}
