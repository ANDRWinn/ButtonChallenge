//
//  Localized.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import Foundation
import SwiftUI

enum Localized {
    enum Common {
        static let cancel = NSLocalizedString("Cancel", comment: "[Common] Cancel button")
        static let primary = NSLocalizedString("Primary", comment: "[Common] Primary button")
        static let secondary = NSLocalizedString("Secondary", comment: "[Common] Secondary button")
    }

    enum StandardTab {
        static let title = NSLocalizedString("Standard", comment: "[Standard Tab] Tab Title")
        static let accountProfile = NSLocalizedString("Account Profile", comment: "[Standard Tab] Account profile form header")
        static let firstName = NSLocalizedString("First Name", comment: "[Standard Tab] First name field placeholder text")
        static let lastName = NSLocalizedString("Last Name", comment: "[Standard Tab] Last name field placeholder text")
        static let disabledHint = NSLocalizedString("Button Disabled. Please fill out both name fields", comment: "[Standard Tab] Standard tab accessibility hint for disabled button")

    }

    enum AsyncTab {
        static let title = NSLocalizedString("Async", comment: "[Async Tab] Tab Title")
        static let orderDetailsHeader = NSLocalizedString("Order Details", comment: "[Async Tab] Order details header")
        static let orderDetails = NSLocalizedString("1 × Dozen Eggs \n2 × Loaves of Bread \n3 × Hand Soap Dispenser \n1 × Bootle of Shampp", comment: "[Async Tab] Order details example text")
        static let orderNotes = NSLocalizedString("Order Notes", comment: "[Async Tab] Order notes placeholder text")
        static let submittingOrder = NSLocalizedString("Submitting order...", comment: "[Async Tab] Submitting order")
        static let submitOrderCTA = NSLocalizedString("Submit Order", comment: "[Async Tab] Submit Order button CTA")
        static let disabledHint = NSLocalizedString("Button Disabled. Please fill out the order notes field", comment: "[Async Tab] Order notes accessibility hint for disabled button")

    }
}

// MARK: - SwiftUI Helper
extension String {
    var key: LocalizedStringKey { LocalizedStringKey(self) }
}
