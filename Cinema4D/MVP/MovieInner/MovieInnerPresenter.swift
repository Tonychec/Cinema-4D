//
//  MovieInnerPresenter.swift
//  Cinema4D
//
//  Created by Nomad on 4/25/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class MovieInnerPresenter {
    private let view: MovieInnerProtocol!
    
    init(view: MovieInnerProtocol) {
        self.view = view
    }
    
    func addToFavorite(film: Movie) {
        CoreDataManager.shared.addToFavorite(film: film)
    }
    
    func removeFromFavorite(id: String) {
        CoreDataManager.shared.removeFromFavorite(id: id)
    }
    
}
