import XCTest
@testable import WBData

final class WBDataTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WBData().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
