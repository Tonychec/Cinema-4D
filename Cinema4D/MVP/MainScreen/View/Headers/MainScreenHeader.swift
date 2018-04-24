//
//  MainScreenHeader.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class MainScreenHeader: UICollectionReusableView {

    @IBOutlet var topView: UIView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segmentedController: UISegmentedControl!
    @IBOutlet var segmentedControllerDevider: UIView!
    @IBOutlet var genreFilterViews: [ViewBtn]!
    @IBOutlet var genreFilterLbls: [UILabel]!
    
    var openGenreSelection: (()->())?

    func configureHeader() {
        configureUI()
    }
    
    func configureUI() {
        searchBar.tintColor = UIColor.white
        segmentedController.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .selected)
        segmentedController.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.lightGray], for: .normal)
        setupSwitcherDeviderPoz()
        setupGenres()
    }
    
    func setupGenres() {
        for index in 0...2 {
            genreFilterViews[index].configureBtn(state: GenreSingleton.sharedInstance.genres[index].state, action: {
                if GenreSingleton.sharedInstance.genres[index].state == .normal {
                    GenreSingleton.sharedInstance.genres[index].state = .selected
                    self.genreFilterViews[index].btnState = .selected
                } else if GenreSingleton.sharedInstance.genres[index].state == .selected {
                    GenreSingleton.sharedInstance.genres[index].state = .normal
                    self.genreFilterViews[index].btnState = .normal
                }
                self.updateGenreLblColors()
            })
            genreFilterLbls[index].textColor = GenreSingleton.sharedInstance.genres[index].state == .normal ? UIColor.white : UIColor.black
            genreFilterLbls[index].text = GenreSingleton.sharedInstance.genres[index].title
        }
        genreFilterViews[3].configureBtn(state: .genre, action: {
            self.openGenreSelection?()
        })
        genreFilterLbls[3].textColor = UIColor.black
        genreFilterLbls[3].text = "Genre"
    }
    
    func updateGenreLblColors() {
        genreFilterLbls[0].textColor = GenreSingleton.sharedInstance.genres[0].state == .normal ? UIColor.white : UIColor.black
        genreFilterLbls[1].textColor = GenreSingleton.sharedInstance.genres[1].state == .normal ? UIColor.white : UIColor.black
        genreFilterLbls[2].textColor = GenreSingleton.sharedInstance.genres[2].state == .normal ? UIColor.white : UIColor.black
    }
    
    func setupSwitcherDeviderPoz() {
        for item in self.constraints {
            if item.identifier == "switchDeviderLeading"  {
                item.constant = self.segmentedController.selectedSegmentIndex == 0 ? 0 : self.frame.width / 2
            } else if item.identifier == "switchDeviderTrealing"  {
                item.constant = self.segmentedController.selectedSegmentIndex != 0 ? 0 : -(self.frame.width / 2)
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func segmentedPressed(_ sender: Any) {
        setupSwitcherDeviderPoz()
    }
}
