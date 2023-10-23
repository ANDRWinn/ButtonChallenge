//
//  OrderService.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import Foundation

// MARK: - Protocol
protocol OrderService: AnyObject {
    var isProcessingOrder: Bool { get }
    func submitOrder() async
}

// MARK: -
class MockOrderService: OrderService, ObservableObject {

    // MARK: - Properties
    @Published var isProcessingOrder: Bool = false

    // MARK: - Public
    func submitOrder() async {
        await MainActor.run {
            isProcessingOrder = true
        }
        try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        await MainActor.run {
            isProcessingOrder = false
        }
    }
}
