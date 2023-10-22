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
    func submitOrder()
}

// MARK: -
class MockOrderService: OrderService, ObservableObject {

    // MARK: - Properties
    @Published var isProcessingOrder: Bool = false

    // MARK: - Public
    func submitOrder() {
        isProcessingOrder = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isProcessingOrder = false
        }
    }
}
