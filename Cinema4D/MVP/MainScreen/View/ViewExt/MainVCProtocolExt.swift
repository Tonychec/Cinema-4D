//
//  MainVCProtocolExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/23/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

extension MainViewController: MainProtocol {
    func show(_ error: String) {
        let alert = UIAlertView()
        alert.title = "Ops..."
        alert.message = error
        alert.addButton(withTitle: "ok")
        alert.show()
    }
    
    func fill(_ movies: [Movie]) {
        if movies.count < 20 {
            isLastLoaded = true
        }
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        self.movies = movies
        collectionView.reloadData()
    }
    
    func fillFilters(_ filters: [Filter]) {
        self.filters = filters
        collectionView.reloadData()
    }
    
    func fillFavorites(_ favorites: [Movie]) {
        self.favoriteMovie = favorites
        collectionView.reloadData()
    }
    
    func add(_ movies: [Movie]) {
        if movies.count < 20 {
            isLastLoaded = true
        }
        self.movies.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    func startLoading() {
        self.view.isUserInteractionEnabled = false
        self.loadingView.isHidden = false
        self.spinner.rotate360()
    }
    
    func endLoading() {
        self.view.isUserInteractionEnabled = true
        self.loadingView.isHidden = true
    }
}
