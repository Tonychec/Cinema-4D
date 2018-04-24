//
//  MovieInnerViewController.swift
//  Cinema4D
//
//  Created by Nomad on 4/24/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class MovieInnerViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var favoriteBtn: UIButton!
    @IBOutlet var movieTitleLbl: UILabel!
    @IBOutlet var movieInfoLbl: UILabel!
    @IBOutlet var movieDescription: UILabel!
    @IBOutlet var closeBtn: UIButton!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupMovieInfo()
    }
    
    func setupMovieInfo() {
        self.imageView.loadImg(id: movie.imageId) { poster in
            self.imageView.image = poster
        }
        self.favoriteBtn.setBackgroundImage(UIImage(named: movie.isFavorite ? "Star Yellow" : "Star Gray"), for: .normal)
        movieTitleLbl.text = movie.title
        movieDescription.text = movie.tagline
        movieInfoLbl.text = movie.releaseDate
        closeBtn.crop(radius: closeBtn.frame.height / 2)
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        // todo logic
    }
}
