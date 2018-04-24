//
//  Constants.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

class Constants {
    static let sharedInstance = Constants()
    private init() {}
    
    // MARK: URL Constants
    let URL_GENRE = "https://api.themoviedb.org/3/genre/movie/list?api_key=fbe4e6280f6a460beaad8ebe2bc130ac"
    let URL_POPULAR = "https://api.themoviedb.org/3/discover/movie?api_key=fbe4e6280f6a460beaad8ebe2bc130ac"
    let URL_SEARCH = "https://api.themoviedb.org/3/search/movie?api_key=fbe4e6280f6a460beaad8ebe2bc130ac&query="
    let URL_FILM_INFO = "https://api.themoviedb.org/3/movie/"
    let URL_IMG = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
}
