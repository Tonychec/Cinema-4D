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
    @IBOutlet var selectedMark: UIImageView!
    
    func configureCell(genre: Filter) {
        genretitle.text = genre.title
        selectedMark.isHidden = !genre.isSelected
    }
}
