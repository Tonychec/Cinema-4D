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
        self.movieTitleLbl.text = movie.title
        self.movieDescription.text = movie.tagline
        
        var info = movie.releaseDate
        self.movieInfoLbl.text = info
    }
    
    func dissmis() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        // todo logic
    }
}
