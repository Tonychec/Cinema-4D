//
//  MainScreenCoreDataExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/24/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

extension MainViewController {
    func coreDataSetup() {
        dispatch_sync(saveQueue) {
            self.managedContext = AppDelegate().managedObjectContext
        }
    }
    
    func prepareImageForSaving(image: UIImage, id: String) {
        dispatch_async(convertQueue) {
            guard let imageData = UIImageJPEGRepresentation(image, 1) else {
                print("jpg error")
                return
            }
            
            self.saveImage(imageData: imageData, id: id)
        }
    }
    
    func saveImage(imageData: NSData, id: String) {
        
        dispatch_barrier_sync(saveQueue) {
            guard let moc = self.managedContext else {
                return
            }
            
            guard let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: moc) as? Image else {
                print("moc error")
                return
            }
            newImage.data = imageData
            newImage.id = id
            
            do {
                try moc.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            moc.refreshAllObjects()
        }
    }

    func loadImages(fetched:(_ images:[Image]?) -> Void) {
        dispatch_async(saveQueue) {
            guard let moc = self.managedContext else {
                return
            }
            
            let fetchRequest = NSFetchRequest(entityName: "Image")
            
            do {
                let results = try moc.executeFetchRequest(fetchRequest)
                let imageData = results as? [Image]
                dispatch_async(dispatch_get_main_queue()) {
                    fetched(images: imageData)
                }
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
                return
            }
        }
    }
}
