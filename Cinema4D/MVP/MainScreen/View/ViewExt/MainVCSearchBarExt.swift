//
//  MainVCSearchBarExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/23/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        switch screenState {
        case .popular, .searchPopular:
            screenState = .searchPopular
            if let text = searchBar.text {
                self.searchString = text
                if text != "" {
                    presenter.search(searchString: text)
                } else {
                    show("Looks like the search string is empty.")
                }
            }
        case .favorite, .searchFavorite:
            screenState = .searchFavorite
            if let text = searchBar.text {
                self.searchString = text
                if text != "" {
                    presenter.searchInFavorite(searchString: text)
                } else {
                    show("Looks like the search string is empty.")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        switch screenState {
        case .searchPopular:
            screenState = .popular
            searchString = ""
            presenter.getPopular()
        case .searchFavorite:
            screenState = .favorite
            searchString = ""
            presenter.getFavorites()
        default:
            break
        }
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
