//
//  MainPresenter.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class MainPresenter {
    private let view: MainProtocol
    private let model = MainModel()
    
    var pageNumber = 1
    
    init(view: MainProtocol) {
        self.view = view
    }
    
    func getPopular(isNextPage: Bool? = false) {
        if isNextPage! {
            pageNumber += 1
        } else {
            pageNumber = 1
        }
        model.getPopular(page: pageNumber) { response in
            if let error = response.error {
                self.view.show(error)
            } else if isNextPage! {
                self.view.add(response.movies!)
            } else {
                self.view.fill(response.movies!)
            }
        }
    }
    
    func search(searchString: String, isNextPage: Bool? = false) {
        if isNextPage! {
            pageNumber += 1
        } else {
            pageNumber = 1
        }
        model.searchMovie(page: pageNumber, searchString: searchString) { response in
            if let error = response.error {
                self.view.show(error)
            } else if isNextPage! {
                self.view.add(response.movies!)
            } else {
                self.view.fill(response.movies!)
            }
        }
    }
    
    func getGenres() {
        model.getGenre { error in
            if let error = error {
                self.view.show(error)
            } else {
                if let filters = CoreDataManager.shared.getFilters() {
                    self.view.fillFilters(filters)
                }
            }
        }
    }
    
    func updateGenreState(id: String, isSelected: Bool) {
        print("update")
        CoreDataManager.shared.updateGenre(id: id, isSelected: isSelected)
    }
}
