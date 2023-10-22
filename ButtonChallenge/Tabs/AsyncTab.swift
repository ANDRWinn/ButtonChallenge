//
//  AsyncTab.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import ButtonKit
import SwiftUI

// MARK: -
struct AsyncTab: View {

    // MARK: - Properties
    @StateObject private var orderService = MockOrderService()
    @StateObject private var viewModel = OrderViewModel()
    @State private var primaryTapCount: Int = 0
    @State private var secondaryTapCount: Int = 0

    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text(LocalizedStrings.AsyncTab.orderDetailsHeader)) {
                Text(LocalizedStrings.AsyncTab.orderDetails)
            }
            Section(header: Text(LocalizedStrings.AsyncTab.orderNotes)) {
                TextEditor(text: $viewModel.orderNotes)
                    .frame(height: 100)
            }

            Text("Primary Button Tap Count: \(primaryTapCount)")
            Text("Secondary Button Tap Count: \(secondaryTapCount)")


            StandardButton(status: .primary, "Primary") {
                orderService.submitOrder()
                primaryTapCount += 1
            }
            .disabled(!viewModel.isValidOrder)
            StandardButton(status: .secondary, "Cancel") {
                primaryTapCount += 1
            }

        }
    }
}

// MARK: - Previews
#Preview {
    AsyncTab()
}

