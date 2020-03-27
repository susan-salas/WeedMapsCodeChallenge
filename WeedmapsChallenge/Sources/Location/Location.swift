//
//  Location.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/27/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation


enum Location {
    case term(String)
    case coordinates(latitude: Double, longitude: Double)
    case error
}
