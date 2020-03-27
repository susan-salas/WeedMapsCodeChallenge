//
//  PhotosAPIService.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/27/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation


struct APIService {
    
    private init() {}
    
    static func fetchData(with apiURL: URL, completion: @escaping (Data?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: apiURL ) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let unwrapData = data else {
                completion(nil, NetworkError.noJSONData)
                return
            }
            
            completion(unwrapData, nil)
            
            }.resume()
        
    }
}
