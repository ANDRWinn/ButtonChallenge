//
//  AccessiblyDisabled.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

// MARK: -
/// A view modifier for controlling whether the user can interact with a view in an accessible manner.
public struct AccessiblyDisabled: ViewModifier {

    // MARK: - Properties
    public let isDisabled: Bool
    public let accessibilityHint: String

    public init(isDisabled: Bool, accessibilityHint: String) {
        let isMissingHintWhenNeeded = isDisabled && accessibilityHint.isEmpty
        assert(!isMissingHintWhenNeeded, "Accessibility hint is missing. It should be set when view is disabled.")
        self.isDisabled = isDisabled
        self.accessibilityHint = accessibilityHint
    }

    // MARK: - Body
    public func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .accessibilityHint(isDisabled ? accessibilityHint : "")
    }
}

// MARK: - Modifier convenience extension
public extension View {
    /// A view modifier for controlling whether the user can interact with a view in an accessible manner.
    /// - Parameters:
    ///   - isDisabled: A Boolean for determining if the user can interact with the view.
    ///   - accessibilityHint: The accessibility hint for VoiceOver explaining why the view is disabled
    /// - Returns: The view with the modifier applied.
    ///
    /// There is an assertion check confirming that there is an accessibility hint set when the button is disabled.
    func accessiblyDisabled(_ isDisabled: Bool, accessibilityHint: String) -> some View {
        modifier(AccessiblyDisabled(isDisabled: isDisabled, accessibilityHint: accessibilityHint))
    }
}

#Preview {
    VStack {
        StandardButton(status: .primary, "Primary", action: { } )
        StandardButton(status: .secondary, "Secondary", action: { } )

        Group {
            StandardButton(status: .primary, "Primary", action: { } )
            StandardButton(status: .secondary, "Secondary", action: { } )
        }
        .accessiblyDisabled(true, accessibilityHint: "Please fill out all fields")
    }
    .padding()
}
