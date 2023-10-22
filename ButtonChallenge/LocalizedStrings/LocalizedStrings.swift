//
//  LocalizedStrings.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import Foundation

enum LocalizedStrings {
    enum Common {
        static let ok = NSLocalizedString("OK", comment: "[Common] Ok button")
    }

    enum StandardTab {
        static let title = NSLocalizedString("Standard", comment: "[Standard Tab] Tab Title")
        static let accountProfile = NSLocalizedString("Account Profile", comment: "[Common] Account profile form header")
        static let firstName = NSLocalizedString("First Name", comment: "[Common] First name field placeholder text")
        static let lastName = NSLocalizedString("Last Name", comment: "[Common] Last name field placeholder text")

    }

    enum DisabledTab {
        static let title = NSLocalizedString("Disabled", comment: "[Disabled Tab] Tab Title")

    }

    enum AsyncTab {
        static let title = NSLocalizedString("Async", comment: "[Async Tab] Tab Title")
        static let orderDetailsHeader = NSLocalizedString("Order Details", comment: "[Async Tab] Order details header")
        static let orderDetails = NSLocalizedString("1 × Dozen Eggs \n2 × Loaves of Bread \n3 × Hand Soap Dispenser \n1 × Bootle of Shampp", comment: "[Async Tab] Order details example text")
        static let orderNotes = NSLocalizedString("Order Notes", comment: "[Async Tab] Order notes placeholder text")

    }

    enum DisabledAsyncTab {
        static let title = NSLocalizedString("Disabled Async", comment: "[Disabled Async Tab] Tab Title")

    }
}
