//
//  UIImageViewExt.swift
//  Cinema4D
//
//  Created by Nomad on 4/23/18.
//  Copyright © 2018 ios.Nomad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImg(id: String, row: Int, completion: @escaping ((UIImage, Int) -> ())) {
        self.loadImg(id: id) { poster in
            completion(poster, row)
        }
    }
    
    func loadImg(id: String, completion: @escaping ((UIImage) -> ())) {
        if let image = CoreDataManager.shared.getImage(id: id) {
            completion(image)
        } else {
            if let imageUrl = URL(string: Constants.sharedInstance.URL_IMG + id) {
                Alamofire.request(imageUrl).responseImage { response in
                    if let image = response.result.value {
                        CoreDataManager.shared.saveImg(image: image, id: id)
                        completion(image)
                    } else {
                        completion(UIImage(named: "placeholderImage")!)
                    }
                }
            } else {
                completion(UIImage(named: "placeholderImage")!)
            }
        }
    }
}
