//
//  AccessiblyDisabled.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

// MARK: -
struct AccessiblyDisabled: ViewModifier {

    // MARK: - Properties
    let isDisabled: Bool
    let accessibilityHint: String

    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .accessibilityHint(accessibilityHint)
    }
}

// MARK: - Modifier convenience extension
extension View {
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
