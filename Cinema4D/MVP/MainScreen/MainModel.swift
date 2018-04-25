//
//  MainModel.swift
//  Cinema4D
//
//  Created by Nomad on 4/22/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MainModel {
    func getGenre(completion: @escaping((String?) -> ())) {
        let request = Alamofire.request(Constants.sharedInstance.URL_GENRE, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        request.responseJSON { apiResponse in
            
            switch apiResponse.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["genres"].arrayValue {
                    CoreDataManager.shared.saveGenre(genre: Filter(title: item["name"].stringValue,
                                                                   id: item["id"].stringValue,
                                                                   isSelected: false))
                }
                completion(nil)
            case.failure(let error):
                let json = JSON(error)
                completion(json["status_message"].stringValue)
            }
        }
    }
        
    func getPopular(page: Int? = nil, completion: @escaping((GetMoviesApiResponse) -> ())) {
        var parameters: [String: Any] = [:]
        if let page = page { parameters["page"] = page }
        parameters["with_genres"] = CoreDataManager.shared.getSelectedFilterId()
        
        let request = Alamofire.request(Constants.sharedInstance.URL_POPULAR, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        request.responseJSON { apiResponse in
            let response = GetMoviesApiResponse()
            
            switch apiResponse.result {
            case .success(let value):
                let json = JSON(value)
                response.movies = self.parsMovies(json: json["results"].arrayValue)
            case .failure(let value):
                let json = JSON(value)
                response.error = json["status_message"].stringValue
            }
            completion(response)
        }
    }
        
    func searchMovie(page: Int? = nil,searchString: String, completion: @escaping((GetMoviesApiResponse) -> ())) {
        let validRequestTxt = searchString.replacingOccurrences(of: " ", with: "+")
        var parameters: [String: Any] = [:]
        if let page = page { parameters["page"] = page }
        
        let request = Alamofire.request("\(Constants.sharedInstance.URL_SEARCH)\(validRequestTxt)", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        request.responseJSON { apiResponse in
            let response = GetMoviesApiResponse()
            switch apiResponse.result {
            case .success(let value):
                let json = JSON(value)
                response.movies = self.parsMovies(json: json["results"].arrayValue)
            case .failure(let value):
                let json = JSON(value)
                response.error = json["status_message"].stringValue
            }
            completion(response)
        }
    }
    
    private func parsMovies(json: [JSON]) -> [Movie] {
        var movies = [Movie]()
        for item in json {
            movies.append(Movie(id: item["id"].stringValue,
                                releaseDate: item["release_date"].stringValue,
                                tagline: item["overview"].stringValue,
                                title: item["title"].stringValue,
                                imageId: item["poster_path"].stringValue))
        }
        return movies
    }
}
