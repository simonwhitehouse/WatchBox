import XCTest
@testable import WBPersistenceStore

final class WBPersistenceStoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WBPersistenceStore().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
