//
//  GenreTableViewExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit

extension GenreScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.filters[indexPath.row].isSelected = !self.filters[indexPath.row].isSelected
        self.presenter.updateGenreState(id: filters[indexPath.row].id, isSelected: filters[indexPath.row].isSelected)
        tableView.reloadRows(at: [indexPath], with: .none)
        isNeedCallback = true
    }
}

extension GenreScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell", for: indexPath) as! GenreTableViewCell
        cell.configureCell(genre: filters[indexPath.row])
        
        return cell
    }
}
