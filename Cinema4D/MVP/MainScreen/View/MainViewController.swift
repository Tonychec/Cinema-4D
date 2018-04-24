//
//  MainViewController.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    // dispatch queues
    let convertQueue = dispatch_queue_create("convertQueue", DISPATCH_QUEUE_CONCURRENT)
    let saveQueue = dispatch_queue_create("saveQueue", DISPATCH_QUEUE_CONCURRENT)
    
    // moc
    var managedContext : NSManagedObjectContext?
    
    var presenter: MainPresenter!
    var movies = [Movie]()
    var isLastLoaded = false
    var refreshControl = UIRefreshControl()
    var screenState: ScreenState = .popular
    var searchString = ""
    
    enum ScreenState {
        case searchPopular
        case searchFavorite
        case popular
        case favorite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MainPresenter(view: self)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.black
        collectionView.addSubview(refreshControl)
        
        coreDataSetup()
        setupCollectionView()
        setupUI()
        presenter.getPopular()
    }
    
    @objc func refresh() {
        switch screenState {
        case .popular:
            presenter.getPopular(isNextPage: false)
        case.searchPopular:
            presenter.search(searchString: searchString)
        default:
            break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    func setupUI() {
        self.title = "Cinema 4D"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
        let genreVC = storyboard.instantiateViewController(withIdentifier: "GenreScreenViewController")
        self.navigationController?.pushViewController(genreVC, animated: true)
    }
}


