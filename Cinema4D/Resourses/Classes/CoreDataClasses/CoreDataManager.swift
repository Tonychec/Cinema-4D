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
}


