//
//  ButtonTheme.swift
//
//
//  Created by Andrew Winn on 10/22/23.
//

import Foundation
import SwiftUI

// MARK: -
public struct ButtonTheme {

    // MARK: - Subtypes
    public struct Fonts {
        public let primaryFont: Font

        public init(primaryFont: Font) {
            self.primaryFont = primaryFont
        }
    }

    public struct Colors {
        public let primaryColor: Color
        public let secondaryColor: Color
        public let gradient: Gradient?

        public init(primaryColor: Color, secondaryColor: Color, gradient: Gradient? = nil) {
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
            self.gradient = gradient
        }
    }

    public struct BackgroundImages {
        public let primaryBackgroundImage: Image
        public let secondaryBackgroundImage: Image

        public init(primaryBackgroundImage: Image, secondaryBackgroundImage: Image) {
            self.primaryBackgroundImage = primaryBackgroundImage
            self.secondaryBackgroundImage = secondaryBackgroundImage
        }
    }

    // MARK: - Properties
    public let fonts: Fonts
    public let colors: Colors
    public let backgroundImages: BackgroundImages?

    public init(fonts: ButtonTheme.Fonts, colors: ButtonTheme.Colors, backgroundImages: ButtonTheme.BackgroundImages? = nil) {
        self.fonts = fonts
        self.colors = colors
        self.backgroundImages = backgroundImages
    }
}

// MARK: - Presets
public extension ButtonTheme {
    private static let defaultFonts: ButtonTheme.Fonts = .init(primaryFont: .title2)
    private static let defaultColors: ButtonTheme.Colors = .init(primaryColor: .blue, secondaryColor: .white, gradient: nil)
    static let `default` = ButtonTheme(fonts: defaultFonts,
                                       colors: defaultColors,
                                       backgroundImages: nil)
}

private struct ButtonThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ButtonTheme = .default
}

public extension EnvironmentValues {
    var buttonTheme: ButtonTheme {
        get { self[ButtonThemeEnvironmentKey.self] }
        set { self[ButtonThemeEnvironmentKey.self] = newValue }
    }
}

public extension View {
    func buttonTheme(_ buttonTheme: ButtonTheme) -> some View {
        environment(\.buttonTheme, buttonTheme)
    }
}
