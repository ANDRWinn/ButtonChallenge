//
//  StandardTab.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

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
            Section(header: Text(LocalizedStrings.StandardTab.accountProfile)) {
                TextField(LocalizedStrings.StandardTab.firstName, text: $viewModel.firstName)
                TextField(LocalizedStrings.StandardTab.lastName, text: $viewModel.lastName)
            }

            Text("Primary Button Tap Count: \(primaryTapCount)")
            Text("Secondary Button Tap Count: \(secondaryTapCount)")


            // Button container goes here
        }
    }
}

// MARK: - Previews
#Preview {
    StandardTab()
}
