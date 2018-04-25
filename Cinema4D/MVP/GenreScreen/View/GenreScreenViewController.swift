//
//  GenreScreenViewController.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class GenreScreenViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    
    var presenter: GenreScreenPresenter!
    var callback: (() -> ())?
    var filters = [Filter]()
    var isNeedCallback = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GenreScreenPresenter(view: self)

        configureUI()
        configureTableView()
        presenter.getGenre()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isNeedCallback {
            callback?()
        }
    }
    
    func configureUI() {
        self.title = "Genre"
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 15
        headerView.crop(width: self.view.frame.width, corners: [.bottomLeft, .bottomRight], radius: 15)
    }
}
