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
        view.startLoading()
        if isNextPage! {
            pageNumber += 1
        } else {
            pageNumber = 1
        }
        model.getPopular(page: pageNumber) { response in
            self.view.endLoading()
            if let error = response.error {
                self.view.show(error)
            } else if let movies = response.movies {
                CoreDataManager.shared.getFavorites { favorites in
                    for index in 0..<movies.count {
                        for item in favorites {
                            if movies[index].id == item.id {
                                movies[index].isFavorite = item.isFavorite
                            }
                        }
                    }
                }
                if isNextPage! {
                    self.view.add(movies)
                } else {
                    self.view.fill(movies)
                }
            }
        }
    }
    
    func search(searchString: String, isNextPage: Bool? = false) {
        view.startLoading()
        if isNextPage! {
            pageNumber += 1
        } else {
            pageNumber = 1
        }
        model.searchMovie(page: pageNumber, searchString: searchString) { response in
            self.view.endLoading()
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
        CoreDataManager.shared.updateGenre(id: id, isSelected: isSelected)
        getPopular()
    }
    
    func addToFavorite(film: Movie) {
        CoreDataManager.shared.addToFavorite(film: film)
    }
    
    func removeFromFavorite(id: String) {
        CoreDataManager.shared.removeFromFavorite(id: id)
    }
    
    func getFavorites() {
        view.startLoading()
        CoreDataManager.shared.getFavorites { favorites in
            self.view.endLoading()
            self.view.fillFavorites(favorites)
        }
    }
    
    func searchInFavorite(searchString: String) {
        view.startLoading()
        CoreDataManager.shared.searchFavorite(searchString: searchString) { searchResult in
            self.view.endLoading()
            self.view.fillFavorites(searchResult)
        }
    }
}
