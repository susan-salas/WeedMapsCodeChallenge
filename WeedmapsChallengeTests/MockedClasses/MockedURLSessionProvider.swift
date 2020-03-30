//
//  MockedURLSessionProvider.swift
//  WeedmapsChallengeTests
//
//  Created by Susan Salas on 3/29/20.
//  Copyright © 2020 Weedmaps, LLC. All rights reserved.
//

import Foundation
@testable import WeedmapsChallenge
 

final class URLSessionMock: URLSessionProtocol {
    private var service:EndPointType
    
    init(service: EndPointType) {
        self.service = service
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        
        if let path = Bundle(for: type(of: self)).path(forResource: service.stubbedResponse, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = HTTPURLResponse(url: service.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
                completionHandler(data, response, nil)
            } catch {
                let response = HTTPURLResponse(url: service.baseURL, statusCode: 500, httpVersion: nil, headerFields: nil)
                completionHandler(nil, response, nil)
            }
        }
        
        return URLSessionDataTaskMock()
    }
}

final class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    
    var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}

