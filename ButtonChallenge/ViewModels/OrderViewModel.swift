//
//  OrderViewModel.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import Combine
import Foundation

// MARK: -
class OrderViewModel: ObservableObject {

    // MARK: - Properties
    @Published var orderNotes: String
    @Published var isValidOrder: Bool

    // MARK: - Initialization
    init() {
        self.orderNotes = ""
        self.isValidOrder = false

        validOrderNotesPublisher()
            .receive(on: RunLoop.main)
            .assign(to: &$isValidOrder)
    }

}

// MARK: - Helpers
private extension OrderViewModel {
    func validOrderNotesPublisher() -> AnyPublisher<Bool, Never> {
        $orderNotes
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
}
