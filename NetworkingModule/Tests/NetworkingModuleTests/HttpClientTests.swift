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
    
    func test_createURL_whenThereIsValidURL_withQueries_itShouldReturnsCorrectURL() {
        let endpointMock = EndpointMock(queries: ["name": "Stuart"])
        let sut = HttpClient()
        let expectedResult = URL(string: "https://testClient?name=Stuart")
        
        let urlResult = sut.createURL(endpointMock)
        
        XCTAssertEqual(urlResult, expectedResult)
    }
    
    
    func test_createURL_whenThereIsValidURL_withoutQueries_itShouldReturnsCorrectURL() {
        let endpointMock = EndpointMock()
        let sut = HttpClient()
        let expectedResult = URL(string: "https://testClient")
        
        let urlResult = sut.createURL(endpointMock)
        
        XCTAssertEqual(urlResult, expectedResult)
    }
    
    func test_prepareRequest_itShouldReturnsCorrectRequest() {
        let endpointMock = EndpointMock()
        let sut = HttpClient()
        
        let requestResult = sut.prepareRequest(endpointMock)
        
        XCTAssertEqual(requestResult?.url, URL(string: "https://testClient"))
        XCTAssertEqual(requestResult?.httpBody, nil)
        XCTAssertEqual(requestResult?.httpMethod, "GET")
        XCTAssertEqual(requestResult?.value(forHTTPHeaderField: "Content-Type"), "application/json")
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
    var url: String
    var method: RequestMethod
    var body: Data?
    var headers: [String: String]
    var queries: [String : String] = [:]
    
    init (url: String = "https://testClient",
          method: RequestMethod = .get,
          body: Data? = nil,
          headers: [String: String] = ["Content-Type": "application/json"],
          queries: [String : String] = [:]
    ) {
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
        self.queries = queries
    }
}
