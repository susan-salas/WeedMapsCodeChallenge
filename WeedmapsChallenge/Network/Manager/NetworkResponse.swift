//
//  NetworkResponse.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/27/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case unknown
    case noJSONData
    case decodingError
}
