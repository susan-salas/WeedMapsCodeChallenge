//
//  Copyright © 2018 Weedmaps, LLC. All rights reserved.
//

import XCTest
@testable import WeedmapsChallenge


class YelpAPIClientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBusinessModelDecodedFromJsonYieldsExpectedResult()  throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "BusinessSearch", ofType: "json") else {  fatalError("Can't find json file") }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(BusinessResponse.self, from: data)
        
        XCTAssertEqual(response.businesses.first?.name, "Brewing Buddha Cafe & Arthouse")
        XCTAssertEqual(response.businesses.first?.image_url, "https://s3-media2.fl.yelpcdn.com/bphoto/yvi8Sv7UCX2Enn2f8V9r-w/o.jpg")
        XCTAssertEqual(response.businesses.first?.url, "https://www.yelp.com/biz/brewing-buddha-cafe-and-arthouse-miami?adjust_creative=hefHs3LeeOye9_tFRylSMQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=hefHs3LeeOye9_tFRylSMQ")
        
        
    }
    
    func testYelpAPIRequestYieldsExpectedResult() {
        
        let mockDataTask = URLSessionMock.init(service: BussinessesAPI.searchTermLocationSearch(searchTerm: "", searchLocation: ""))
        let dataProvider = URLSessionProvider.init(session: mockDataTask)
        
        dataProvider.request(type: BusinessResponse.self, service: BussinessesAPI.searchTermLocationSearch(searchTerm: "", searchLocation: "")) { response in
            switch response {
            case let .success(response):
                XCTAssertEqual(response.businesses.first?.name, "Brewing Buddha Cafe & Arthouse")
                XCTAssertEqual(response.businesses.first?.image_url, "https://s3-media2.fl.yelpcdn.com/bphoto/yvi8Sv7UCX2Enn2f8V9r-w/o.jpg")
                XCTAssertEqual(response.businesses.first?.url, "https://www.yelp.com/biz/brewing-buddha-cafe-and-arthouse-miami?adjust_creative=hefHs3LeeOye9_tFRylSMQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=hefHs3LeeOye9_tFRylSMQ")
                default:
                break
            }
        }
    }
}
