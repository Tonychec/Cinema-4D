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
    func loadImg(url: String?, row: Int, completion: @escaping ((UIImage, Int) -> ())) {
        if let url = url, let imageUrl = URL(string: Constants.sharedInstance.URL_IMG + url) {
            Alamofire.request(imageUrl).responseImage { response in
                if let image = response.result.value {
                    completion(image, row)
                } else {
                    completion(UIImage(named: "placeholderImage")!, row)
                }
            }
        } else {
            completion(UIImage(named: "placeholderImage")!, row)
        }
    }
}
