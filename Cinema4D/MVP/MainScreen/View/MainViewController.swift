//
//  MainViewController.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var spinner: UIImageView!
    
    var presenter: MainPresenter!
    var movies = [Movie]()
    var isLastLoaded = false
    var refreshControl = UIRefreshControl()
    var screenState: ScreenState = .popular
    var searchString = ""
    var filters = [Filter]()
    var favoriteMovie = [Movie]()
    var segmentedController: UISegmentedControl!
    
    enum ScreenState {
        case searchPopular
        case searchFavorite
        case popular
        case favorite
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if presenter != nil {
            presenter.getGenres()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        collectionView.addSubview(refreshControl)
        
        setupCollectionView()
        setupUI()
        presenter.getGenres()
        presenter.getPopular()
    }
    
    @objc func refresh() {
        switch screenState {
        case .popular:
            presenter.getPopular(isNextPage: false)
        case.searchPopular:
            presenter.search(searchString: searchString)
        case .favorite:
            presenter.getFavorites()
        case .searchFavorite:
            presenter.search(searchString: searchString)
        }
    }
    
    @objc func moveToTop() {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    func setupUI() {
        self.title = "Cinema 4D"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainScreenHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.register(UINib(nibName: "MainScreenCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MainScreenCollectionViewCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width/2 - 15, height: (self.view.frame.width/2) * 1.5)
        layout.headerReferenceSize = CGSize(width: 0, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
    }
    
    func openGenreSelection() {
        let storyboard = UIStoryboard(name: "GenreScreen", bundle: nil)
        let genreVC = storyboard.instantiateViewController(withIdentifier: "GenreScreenViewController") as! GenreScreenViewController
        genreVC.callback = { self.presenter.getPopular() }
        self.navigationController?.pushViewController(genreVC, animated: true)
    }
    
    func openMovieInfo(movieRow: Int) {
        let storyboard = UIStoryboard(name: "MovieInner", bundle: nil)
        let movieVC = storyboard.instantiateViewController(withIdentifier: "MovieInnerViewController") as! MovieInnerViewController
        movieVC.movie = segmentedController.selectedSegmentIndex == 0 ? movies[movieRow] : favoriteMovie[movieRow]
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func segmentedControllerPressed() {
        if segmentedController.selectedSegmentIndex == 0 {
            self.screenState = .popular
            presenter.getPopular()
        } else {
            self.screenState = .favorite
            presenter.getFavorites()
        }
    }
    
    func updateFilterState(id: String, isSelected: Bool) {
        presenter.updateGenreState(id: id, isSelected: isSelected)
    }
    
    func favoriteBtnPressed(row: Int) {
        if segmentedController.selectedSegmentIndex == 0 {
            if movies[row].isFavorite {
                presenter.removeFromFavorite(id: movies[row].id)
            } else {
                presenter.addToFavorite(film: movies[row])
            }
        } else {
            if favoriteMovie[row].isFavorite {
                presenter.removeFromFavorite(id: favoriteMovie[row].id)
            } else {
                presenter.addToFavorite(film: favoriteMovie[row])
            }
        }
        collectionView.reloadItems(at: [IndexPath(row: row, section: 0)])
    }
}
