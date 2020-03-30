//
//  BussinessesAPI.swift
//  WeedmapsChallenge
//
//  Created by Susan Salas on 3/25/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation

public enum BussinessesAPI {
    case searchTermLocationSearch(searchTerm: String, searchLocation: String)
    case searchTermCoordiantes(searchTerm: String, latitude: String, longitude: String)

}


extension BussinessesAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.yelp.com/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return "v3/businesses/search"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        
        switch self {
        case .searchTermCoordiantes(let searchTerm, let latitude, let longitude):
            let parameters = ["term":searchTerm, "latitude": latitude, "longitude": longitude]
            return .requestParameters(parameters)

        case .searchTermLocationSearch(let searchTerm, let searchLocation):
            let parameters = ["term":searchTerm, "location": searchLocation]
            return .requestParameters(parameters)
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": "Bearer zGmWJsvsyA8eCdn1dxees74MR919pTwanTkUzWiVIbcrLf3IP6sZWalTK3ZgUUyG5tGZOZeW8OVrKlZCfXzlo-sUOi4ONhFFZz0tl5MY_TA2Hxe4dhGIRygjdph7XnYx"]
    }
    
    var parametersEncoding: ParameterEncoding {
        return .url
    }
    
    var stubbedResponse:String {
        return "BusinessSearch"
    }
}


