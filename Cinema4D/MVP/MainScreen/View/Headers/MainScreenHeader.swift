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
    var filters = [Filter]()
    var updateFilterState: ((String, Bool) ->())?

    func configureHeader() {
        configureUI()
    }
    
    func configureUI() {
        searchBar.tintColor = UIColor.white
        segmentedController.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black], for: .selected)
        segmentedController.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.lightGray], for: .normal)
        setupSwitcherDeviderPoz()
        if !filters.isEmpty {
            setupGenres()
        }
    }
    
    func setupGenres() {
        for index in 0...2 {
            genreFilterViews[index].configureBtn(state: filters[index].isSelected ? .selected : .normal, action: {
                self.filters[index].isSelected = !self.filters[index].isSelected
                self.updateFilterState?(self.filters[index].id, !self.filters[index].isSelected)
                self.genreFilterViews[index].btnState = self.filters[index].isSelected ? .selected : .normal
                self.updateGenreLblColors()
            })
            genreFilterLbls[index].textColor = filters[index].isSelected ? UIColor.black : UIColor.white
            genreFilterLbls[index].text = filters[index].title
        }
        genreFilterViews[3].configureBtn(state: .genre, action: {
            self.openGenreSelection?()
        })
        genreFilterLbls[3].textColor = UIColor.black
        genreFilterLbls[3].text = "Genre"
    }

    func updateGenreLblColors() {
        genreFilterLbls[0].textColor = filters[0].isSelected ? UIColor.black : UIColor.white
        genreFilterLbls[1].textColor = filters[1].isSelected ? UIColor.black : UIColor.white
        genreFilterLbls[2].textColor = filters[2].isSelected ? UIColor.black : UIColor.white
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
