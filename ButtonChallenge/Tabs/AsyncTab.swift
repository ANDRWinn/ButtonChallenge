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
    @State private var secondaryTapCount: Int = 0

    // MARK: - Body
    var body: some View {
        Form {
            Section(header: Text(Localized.AsyncTab.orderDetailsHeader)) {
                Text(Localized.AsyncTab.orderDetails)
            }
            Section(header: Text(Localized.AsyncTab.orderNotes)) {
                TextEditor(text: $viewModel.orderNotes)
                    .frame(height: 100)
            }

            Text(orderService.isProcessingOrder ? Localized.AsyncTab.submittingOrder : "")
            Text("Cancel Button Tap Count: \(secondaryTapCount)")


            StandardButton(status: .primary, Localized.AsyncTab.submittingOrder.key, asyncAction: orderService.submitOrder)
                .accessiblyDisabled(!viewModel.isValidOrder || orderService.isProcessingOrder,
                                    accessibilityHint: Localized.AsyncTab.disabledHint)
            StandardButton(status: .secondary, Localized.Common.cancel.key) {
                secondaryTapCount += 1
            }
        }
    }
}

// MARK: - Previews
#Preview {
    AsyncTab()
}

