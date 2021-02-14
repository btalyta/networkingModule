import XCTest
@testable import NetworkingModule

final class NetworkingModuleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NetworkingModule().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
