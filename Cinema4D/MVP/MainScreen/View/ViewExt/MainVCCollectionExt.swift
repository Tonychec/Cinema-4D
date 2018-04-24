//
//  MainVCCollectionExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit
import CoreData

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenCollectionViewCell", for: indexPath) as! MainScreenCollectionViewCell
        cell.configureCell(film: movies[indexPath.row], row: indexPath.row) // todo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! MainScreenHeader
        headerView.configureHeader()
        headerView.topView.crop(width: collectionView.frame.width, corners: [.bottomLeft, .bottomRight], radius: 15)
        headerView.openGenreSelection = self.openGenreSelection
        headerView.searchBar.delegate = self
        
        return headerView
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openMovieInfo(movieRow: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch screenState {
        case .popular:
            if indexPath.row == movies.count - 2 && !isLastLoaded {
                presenter.getPopular(isNextPage: true)
            }
        case .searchPopular:
            if indexPath.row == movies.count - 2 && !isLastLoaded {
                presenter.search(searchString: searchString, isNextPage: true)
            }
        default:
            break
        }

        let cell = cell as! MainScreenCollectionViewCell
        if !cell.spinner.isHidden {
            cell.spinner.rotate360()
        }
    }
}
