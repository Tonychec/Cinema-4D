//
//  MainScreenCollectionViewCell.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet var shadowView: UIView!
    
    @IBOutlet var favoriteBtn: UIButton!
    @IBOutlet var title: UILabel!
    @IBOutlet var spinner: UIImageView!
    @IBOutlet var imageContainer: UIView!
    @IBOutlet var imageView: UIImageView!
    
    var row: Int!
    
    func configureCell(film: Movie, row: Int) {
        imageView.image = nil
        spinner.isHidden = false
        spinner.rotate360()
        self.row = row
        self.title.text = film.title
        self.favoriteBtn.setBackgroundImage(UIImage(named: film.isFavorite ? "Star Yellow" : "Star Gray"), for: .normal)
        configureUI()
        
        self.imageView.loadImg(id: film.imageId, row: row) { poster, forRow in
            if forRow == self.row {
                self.imageView.image = poster
                self.spinner.isHidden = true
            }
        }
    }
    
    func configureUI() {
        imageView.crop(radius: 15)
        shadowView.crop(radius: 15)
        shadowView.setShadow(opacity: 1, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3), radius: 6)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        
    }
}
