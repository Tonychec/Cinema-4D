//
//  GenreTableViewCell.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    @IBOutlet var genretitle: UILabel!
    @IBOutlet var filmQuantity: UILabel!
    
    func configureCell(genre: GenreFilter) {
        genretitle.text = genre.title
        if let counter = genre.filmCounter {
            filmQuantity.text = "\(counter)"
        } else {
            filmQuantity.text = ""
        }
    }
}
