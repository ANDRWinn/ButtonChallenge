import XCTest
@testable import ButtonKit

final class ButtonKitTests: XCTestCase {

    func testDefaultTheme() {
        let defaultTheme = ButtonTheme.default

        XCTAssertTrue(defaultTheme.fonts.primaryFont == .title2)
        XCTAssertTrue(defaultTheme.colors.primaryColor == .blue)
        XCTAssertTrue(defaultTheme.colors.secondaryColor == .white)
    }

    func testCreateTheme() {
        let theme = ButtonTheme(fonts: .init(primaryFont: .title2),
                                colors: .init(primaryColor: .blue,
                                              secondaryColor: .white))
        let defaultTheme = ButtonTheme.default

        XCTAssertTrue(defaultTheme.fonts.primaryFont == theme.fonts.primaryFont)
        XCTAssertTrue(defaultTheme.colors.primaryColor == theme.colors.primaryColor)
        XCTAssertTrue(defaultTheme.colors.secondaryColor == theme.colors.secondaryColor)
    }
}

