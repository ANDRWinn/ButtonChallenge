//
//  StandardTab.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import ButtonKit
import SwiftUI

// MARK: -
struct StandardTab: View {

    // MARK: - Properties
    @StateObject private var viewModel: FormViewModel = .init()
    @State private var primaryTapCount: Int = 0
    @State private var secondaryTapCount: Int = 0

    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text(Localized.StandardTab.accountProfile)) {
                TextField(Localized.StandardTab.firstName, text: $viewModel.firstName)
                TextField(Localized.StandardTab.lastName, text: $viewModel.lastName)
            }

            Text("Primary Button Tap Count: \(primaryTapCount)")
            Text("Secondary Button Tap Count: \(secondaryTapCount)")

            StandardButton(status: .primary, Localized.Common.primary.key) { primaryTapCount += 1 }
                .accessiblyDisabled(!viewModel.isValidForm, accessibilityHint: Localized.StandardTab.disabledHint)
            StandardButton(status: .secondary, Localized.Common.secondary.key) { secondaryTapCount += 1 }
        }
    }
}

// MARK: - Previews
#Preview {
    StandardTab()
}
