//
//  GenreProtocolExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/25/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import  UIKit

extension GenreScreenViewController: GenreScreenProtocol {
    func fill(_ filters: [Filter]) {
        self.filters = filters
        tableView.reloadData()
    }
    
    func show(_ error: String) {
        let alert = UIAlertView()
        alert.title = "Ops..."
        alert.message = error
        alert.addButton(withTitle: "ok")
        alert.show()
    }
}
