//
//  MainProtocol.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

protocol MainProtocol {
    func show(_ error: String)
    func fill(_ movies: [Movie])
    func fillFavorites(_ favorites: [Movie])
    func fillFilters(_ filters: [Filter])
    func add(_ movies: [Movie])
    func startLoading()
    func endLoading()
}
