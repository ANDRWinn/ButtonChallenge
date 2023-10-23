//
//  ButtonKitSnapshotTests.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SnapshotTesting
import XCTest
@testable import ButtonKit

// Tested on Xcode Version 15.0.1 (15A507) under iPhone 15 (iOS 17.0.1 (21A342)) simulator
final class ButtonKitSnapshotTests: XCTestCase {

    func testDefaultTheme() {
        let defaultTheme = ButtonTheme.default
        assertSnapshot(of: defaultTheme, as: .dump, record: false)
    }

    func testPrimaryStandardButton() {
        let button = StandardButton(status: .primary, "Primary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true)
        assertSnapshot(of: button, as: .image, record: false)
    }

    func testSecondaryStandardButton() {
        let button = StandardButton(status: .secondary, "Secondary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true)
        assertSnapshot(of: button, as: .image, record: false)
    }

    func testDisabledPrimaryStandardButton() {
        let button = StandardButton(status: .primary, "Primary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true).disabled(true)
        assertSnapshot(of: button, as: .image, record: false)
    }

    func testDisabledSecondaryStandardButton() {
        let button = StandardButton(status: .secondary, "Secondary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true).disabled(true)
        assertSnapshot(of: button, as: .image, record: false)
    }

    func testAccessiblyDisabledPrimaryStandardButton() {
        let button = StandardButton(status: .primary, "Primary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true).accessiblyDisabled(true, accessibilityHint: "Hint")
        assertSnapshot(of: button, as: .image, record: false)
    }

    func testAccessiblyDisabledSecondaryStandardButton() {
        let button = StandardButton(status: .secondary, "Secondary", action: { }).frame(width: 200).padding().fixedSize(horizontal: true, vertical: true).accessiblyDisabled(true, accessibilityHint: "Hint")
        assertSnapshot(of: button, as: .image, record: false)
    }
}
