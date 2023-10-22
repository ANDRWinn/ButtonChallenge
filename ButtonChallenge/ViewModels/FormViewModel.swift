//
//  FormViewModel.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import Combine
import Foundation

// MARK: -
class FormViewModel: ObservableObject {


    // MARK: - Properties
    @Published var firstName: String
    @Published var lastName: String
    @Published var isValidForm: Bool

    // MARK: - Initialization
    init() {
        self.firstName = ""
        self.lastName = ""
        self.isValidForm = false

        validFormPublisher()
            .receive(on: RunLoop.main)
            .assign(to: &$isValidForm)
    }
}

// MARK: - Helpers
private extension FormViewModel {
    func validFirstNamePublisher() -> AnyPublisher<Bool, Never> {
        $firstName
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    func validLastNamePublisher() -> AnyPublisher<Bool, Never> {
        $lastName
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    func validFormPublisher() -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(validFirstNamePublisher(), validLastNamePublisher())
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}
