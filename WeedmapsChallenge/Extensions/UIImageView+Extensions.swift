//
//  UIImageView+Extensions.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/26/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func loadImage(from endPoint: String) {
        
        let imageEndPoint = endPoint
        
        func setImage(_ image: UIImage) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        if let imageFromCache = UIImage.imageCache.object(forKey: endPoint as AnyObject) as? UIImage {
            setImage(imageFromCache)
            return
        }
        
        UIImage.cacheImage(from: endPoint) { (image) in
            guard let imageFromCache = image else {
                return
            }
            setImage(imageFromCache)
        }
    }
}

