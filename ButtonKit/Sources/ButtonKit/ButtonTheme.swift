//
//  ButtonTheme.swift
//
//
//  Created by Andrew Winn on 10/22/23.
//

import Foundation
import SwiftUI

// MARK: -
/// A structure that contains everything a button needs to style itself, such as fonts, colors, etc.
public struct ButtonTheme {

    // MARK: - Subtypes
    /// A container for all the possible fonts for a theme. Which font a button uses depends on its style.
    public struct Fonts {
        /// The primary font for a theme. Used for the text label on a button
        public let primaryFont: Font

        public init(primaryFont: Font) {
            self.primaryFont = primaryFont
        }
    }
    /// A container for all the possible fonts for a theme. Which font a button uses depends on its style.
    public struct Colors {
        /// The primary color of a button. Used as the button background color for a ``StandardButtonStyle/Status/primary`` styled button and used as the font color for a ``StandardButtonStyle/Status/secondary`` styled button.
        public let primaryColor: Color
        /// The secondary color of a button. Used as the font color for a ``StandardButtonStyle/Status/primary`` styled button and used as the button background color for a ``StandardButtonStyle/Status/secondary`` styled button.
        public let secondaryColor: Color

        /// - Parameters:
        ///   - primaryColor: The primary color of a button. Used as the button background color for a ``StandardButtonStyle/Status/primary`` styled button and used as the font color for a ``StandardButtonStyle/Status/secondary`` styled button.
        ///   - secondaryColor: The secondary color of a button. Used as the font color for a ``StandardButtonStyle/Status/primary`` styled button and used as the button background color for a ``StandardButtonStyle/Status/secondary`` styled button
        public init(primaryColor: Color, secondaryColor: Color) {
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
        }
    }

    // MARK: - Properties
    /// The possible fonts available in the theme.
    public let fonts: Fonts
    /// The possible colors available in the theme.
    public let colors: Colors

    public init(fonts: ButtonTheme.Fonts, colors: ButtonTheme.Colors) {
        self.fonts = fonts
        self.colors = colors
    }
}

// MARK: - Presets
public extension ButtonTheme {
    private static let defaultFonts: ButtonTheme.Fonts = .init(primaryFont: .title2)
    private static let defaultColors: ButtonTheme.Colors = .init(primaryColor: .blue, secondaryColor: .white)
    /// A default theme used when no other theme is available in the view environment.
    static let `default` = ButtonTheme(fonts: defaultFonts,
                                       colors: defaultColors)
}

private struct ButtonThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ButtonTheme = .default
}

public extension EnvironmentValues {
    /// A key for accessing the value of the current ``ButtonTheme`` in the environment
    var buttonTheme: ButtonTheme {
        get { self[ButtonThemeEnvironmentKey.self] }
        set { self[ButtonThemeEnvironmentKey.self] = newValue }
    }
}

public extension View {
    /// A view modifier to conveniently apply the theme to the current view hierarchy.
    /// - Parameter buttonTheme: The theme to use in the current view environment.
    /// - Returns: The view with the current theme applied.
    ///
    /// Use this modifier to set a specific button theme for all buttons within a view:
    /// ```swift
    ///     VStack {
    ///         StandardButton(status: .primary, "Primary", action: {...} )
    ///         StandardButton(status: .secondary, "Secondary", action: {...} )
    ///         }
    ///         .buttonTheme(myCustomTheme)
    ///     StandardButton(status: .primary, "Cancel", action: {...} )
    /// ```
    ///
    /// In the above example, the primary and secondary buttons will use the `myCustomTheme` while the cancel button will use the default theme.
    func buttonTheme(_ buttonTheme: ButtonTheme) -> some View {
        environment(\.buttonTheme, buttonTheme)
    }
}
