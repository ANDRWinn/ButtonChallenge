//
//  AccessiblyDisabled.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

// MARK: -
public struct AccessiblyDisabled: ViewModifier {

    // MARK: - Properties
    public let isDisabled: Bool
    public let accessibilityHint: String

    // MARK: - Body
    public func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .accessibilityHint(accessibilityHint)
    }
}

// MARK: - Modifier convenience extension
public extension View {
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
