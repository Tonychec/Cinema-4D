//
//  CoreDataManager.swift
//  Cinema4D
//
//  Created by Nomad on 4/24/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveImg(image: UIImage, id: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [Image]
            if result.isEmpty {
                guard let imageData = UIImageJPEGRepresentation(image, 1) else {
                    return
                }
            
                let context = appDelegate.getManagedContext()
                let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)
                let newRecord = NSManagedObject(entity: entity!, insertInto: context)
                newRecord.setValue(imageData, forKey: "data")
                newRecord.setValue(id, forKey: "id")
                appDelegate.saveContext()
            }
        } catch {
        }
    }

    func getImage(id: String) -> UIImage? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [Image]
            if result.isEmpty {
                return nil
            } else {
                return UIImage(data: result[0].data! as Data)
            }
        } catch {
            return nil
        }
    }
    
    // todo: need to use!
    func clearImages() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            let context = appDelegate.getManagedContext()
            let result = try context.fetch(request) as! [Image]
            for search in result {
                context.delete(search)
            }
            appDelegate.saveContext()
        } catch {
        }
    }
    
    func saveGenre(genre: Filter) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreFilter")
        request.predicate = NSPredicate(format: "id == %@", genre.id)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [GenreFilter]
            if result.isEmpty {
                let context = appDelegate.getManagedContext()
                let entity = NSEntityDescription.entity(forEntityName: "GenreFilter", in: context)
                let newRecord = NSManagedObject(entity: entity!, insertInto: context)
                newRecord.setValue(genre.id, forKey: "id")
                newRecord.setValue(genre.title, forKey: "title")
                newRecord.setValue(genre.isSelected, forKey: "isSelected")
                appDelegate.saveContext()
            } else {
            }
        } catch {
        }
    }
    
    func updateGenre(id: String, isSelected: Bool) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreFilter")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [GenreFilter]
            if !result.isEmpty {
                result[0].setValue(isSelected, forKey: "isSelected")
                appDelegate.saveContext()
            }
        } catch {
        }
    }
    
    func getFilters() -> [Filter]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreFilter")
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [GenreFilter]
            var filters = [Filter]()
            for item in result {
                filters.append(Filter(title: item.title!, id: item.id!, isSelected: item.isSelected))
            }
            return filters
        } catch {
            return nil
        }
    }
    
    func getSelectedFilterId() -> String {
        var selectedFilterId = ""
        
        if let filters = self.getFilters() {
            for item in filters {
                if item.isSelected {
                    selectedFilterId.append(contentsOf: "\(item.id)" + ",")
                }
            }
        }
        if selectedFilterId.last == "," {
            selectedFilterId.removeLast()
        }
        return selectedFilterId
    }
    
    // todo: need to use!
    func clearFilters() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        do {
            let context = appDelegate.getManagedContext()
            let result = try context.fetch(request) as! [Image]
            for search in result {
                context.delete(search)
            }
            appDelegate.saveContext()
        } catch {
        }
    }
    
    func addToFavorite(film: Movie) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "id == %@", film.id)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [FavoriteMovie]
            if result.isEmpty {
                let context = appDelegate.getManagedContext()
                let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovie", in: context)
                let newRecord = NSManagedObject(entity: entity!, insertInto: context)
                newRecord.setValue(film.id, forKey: "id")
                newRecord.setValue(Date(), forKey: "addDate")
                newRecord.setValue(true, forKey: "isFavorite")
                newRecord.setValue(film.releaseDate, forKey: "releaseDate")
                newRecord.setValue(film.tagline, forKey: "tagline")
                newRecord.setValue(film.title, forKey: "title")
                newRecord.setValue(film.imageId, forKey: "imageId")
                newRecord.setValue(film.userMark, forKey: "userMark")
                appDelegate.saveContext()
            }
        } catch {
        }
    }
    
    func removeFromFavorite(id: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let context = appDelegate.getManagedContext()
            let result = try context.fetch(request) as! [FavoriteMovie]
            for search in result {
                context.delete(search)
            }
            appDelegate.saveContext()
        } catch {
        }
    }
    
    func getFavorites(complation: @escaping(([Movie]) -> ())) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [FavoriteMovie]
            var movies = [Movie]()
            for item in result {
                let movie = Movie(id: item.id!, releaseDate: item.releaseDate!, tagline: item.tagline!,
                                  title: item.title!, imageId: item.imageId!)
                movie.isFavorite = true
                if let mark = item.userMark {
                    movie.userMark = mark
                }
                movie.addDate = item.addDate!
                movies.append(movie)
            }
            complation(movies)
        } catch {
            complation([Movie]())
        }
    }
    
    func searchFavorite(searchString: String, complation: @escaping(([Movie]) -> ())) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        request.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchString)
        do {
            let result = try appDelegate.getManagedContext().fetch(request) as! [FavoriteMovie]
            var movies = [Movie]()
            for item in result {
                let movie = Movie(id: item.id!, releaseDate: item.releaseDate!, tagline: item.tagline!,
                                  title: item.title!, imageId: item.imageId!)
                movie.isFavorite = true
                if let mark = item.userMark {
                    movie.userMark = mark
                }
                movie.addDate = item.addDate!
                movies.append(movie)
            }
            complation(movies)
        } catch {
            complation([Movie]())
        }
    }
    
    // todo: need to use!
    func clearFavorite() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        do {
            let context = appDelegate.getManagedContext()
            let result = try context.fetch(request) as! [FavoriteMovie]
            for search in result {
                context.delete(search)
            }
            appDelegate.saveContext()
        } catch {
        }
    }
}


