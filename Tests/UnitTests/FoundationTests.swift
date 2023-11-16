import XCTest
import Foundation

final class FoundationTests: XCTestCase {
    func testExtraArgumentsInStringFormat() {
        let formatWithTwoPlaceHolders = "It is not possible to read the file %@ at path %@."
        let fakeFileName = "fakefile.crt"
        let fakeFilePath = "/fakepath/dir/dir/dir"
        let extraArg = "something"
        let stringWithThreeArguments = String(format: formatWithTwoPlaceHolders, fakeFileName, fakeFilePath, extraArg)
        let expectedResult = "It is not possible to read the file \(fakeFileName) at path \(fakeFilePath)."
        XCTAssertEqual(stringWithThreeArguments, expectedResult)
    }
}
