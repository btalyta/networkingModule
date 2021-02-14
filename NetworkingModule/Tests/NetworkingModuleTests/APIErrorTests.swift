//
//  File.swift
//  
//
//  Created by Bárbara Souza on 14/02/21.
//

import Foundation
import XCTest

@testable import NetworkingModule

class APIErrorTests: XCTestCase {
    func test_error_whenIsJsonConversionFailure_returnsCorrectLocalizedDescription() {
        let sut: APIError = .jsonConversionFailure
        
        XCTAssertEqual(sut.localizedDescription, "Could not display results.")
    }
    
    func test_error_whenIsDecode_returnsCorrectLocalizedDescription() {
        let sut: APIError = .decode
        XCTAssertEqual(sut.localizedDescription, "Could not display results.")
    }
    
    func test_error_whenIsInvalidData_returnsCorrectLocalizedDescription() {
        let sut: APIError = .invalidData
        XCTAssertEqual(sut.localizedDescription, "Could not display results.")
    }
    
    func test_error_whenIsTimeout_returnsCorrectLocalizedDescription() {
        let sut: APIError = .timeout
        XCTAssertEqual(sut.localizedDescription, "Connection error.")
    }
    
    func test_error_whenIsService_returnsCorrectLocalizedDescription() {
        let sut: APIError = .service
        XCTAssertEqual(sut.localizedDescription, "Could not connect to the server.")
    }
    
    func test_error_whenIsRequest_returnsCorrectLocalizedDescription() {
        let sut: APIError = .request
        XCTAssertEqual(sut.localizedDescription, "Could not connect to the server.")
    }
}
