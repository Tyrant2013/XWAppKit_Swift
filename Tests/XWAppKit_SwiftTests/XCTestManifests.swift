import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(XWAppKit_SwiftTests.allTests),
    ]
}
#endif
