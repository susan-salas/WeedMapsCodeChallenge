//
//  HTTPTask.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/24/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String:String]

enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
}
