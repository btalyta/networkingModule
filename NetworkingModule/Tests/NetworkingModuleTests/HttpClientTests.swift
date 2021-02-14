//
//  File.swift
//  
//
//  Created by Bárbara Souza on 14/02/21.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import NetworkingModule

class HttpClientTests: XCTestCase {
    func test_request_whenTheRequestIsSuccessful_shouldReturnDataInCompletion() {
        let endpointMock = EndpointMock()
        let sut = HttpClient()
        stubRequest()
        let resultExpectation = self.expectation(description: "result value")
        
        sut.request(endpointMock) { result in
            switch result {
            case .success(let resultData):
                XCTAssertEqual(resultData, Data())
            default:
                XCTFail("This test was expecting a success result")
            }
            resultExpectation.fulfill()
        }
        
        wait(for: [resultExpectation], timeout: 1)
    }
    
    func test_request_whenTheRequestFails_shouldReturnErrorInCompletion() {
        let endpointMock = EndpointMock()
        let sut = HttpClient()
        stubRequest(with: false)
        let errorExpectation = self.expectation(description: "error value")
        
        sut.request(endpointMock) { result in
            switch result {
            case .failure(let serviceError):
                guard let error = serviceError as? APIError else {
                    XCTFail("Unexpected result")
                    return
                }
                XCTAssertEqual(error, APIError.unauthorized)
            default:
                XCTFail("This test was expecting a fail result")
            }
            errorExpectation.fulfill()
        }
        
        wait(for: [errorExpectation], timeout: 1)
    }
    
    func stubRequest(with success: Bool = true) {
        stub(condition: isHost("testClient")) { _ in
            if success {
                return HTTPStubsResponse(data: Data() ,
                                         statusCode: 200,
                                         headers: ["Content-Type": "application/json"])
            }
            
            return HTTPStubsResponse(data: Data(),
                                     statusCode: 401,
                                     headers: nil)
        }
    }
}

class EndpointMock: Endpoint {
    var url: String {
        return "https://testClient"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [String: String] = ["Content-Type": "application/json"]
}
