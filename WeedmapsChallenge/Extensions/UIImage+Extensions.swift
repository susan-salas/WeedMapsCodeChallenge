//
//  UIImage+Extensions.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/27/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) -> ()) {
        
        guard let url = URL.init(string: endPoint) else { return }
        
        APIService.fetchData(with: url) { (data, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let currData = data else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: currData) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: endPoint as AnyObject)
            }
            
            completion(image)
        }
        
    }
}
