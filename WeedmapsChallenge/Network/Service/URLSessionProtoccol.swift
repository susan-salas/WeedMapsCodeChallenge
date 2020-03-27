//
//  URLSessionProtoccol.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/25/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation


protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
