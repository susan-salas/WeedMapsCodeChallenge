//
//  EndPointType.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/24/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation


protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var parametersEncoding: ParameterEncoding { get }
}
