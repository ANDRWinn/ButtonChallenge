//
//  HolidayThemes.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import ButtonKit
import SwiftUI

enum HolidayThemes {
    private static let holidayFonts: ButtonTheme.Fonts = .init(primaryFont: .largeTitle)
    private static let holidayColors: ButtonTheme.Colors = .init(primaryColor: .green, secondaryColor: .red)
    static let holidayButtonTheme: ButtonTheme = .init(fonts: holidayFonts, colors: holidayColors)
}
