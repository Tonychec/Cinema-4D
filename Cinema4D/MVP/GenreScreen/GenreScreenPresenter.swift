//
//  GenreScreenPresenter.swift
//  Cinema4D
//
//  Created by Nomad on 4/25/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class GenreScreenPresenter {
    private let view: GenreScreenProtocol!
    
    init(view: GenreScreenProtocol) {
        self.view = view
    }
    
    func getGenre() {
        if let filters = CoreDataManager.shared.getFilters() {
            self.view.fill(filters)
        } else {
            self.view.show("Failed to load filters, go to the main screen and update the information (by pull for refresh)") // todo local
        }
    }
    
    func updateGenreState(id: String, isSelected: Bool) {
        CoreDataManager.shared.updateGenre(id: id, isSelected: isSelected)
    }
}
