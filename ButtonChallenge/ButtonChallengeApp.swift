//
//  ButtonChallengeApp.swift
//  ButtonChallenge
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

@main
struct ButtonChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                StandardTab()
                    .tabItem {
                        Label(Localized.StandardTab.title, systemImage: "list.dash")
                    }
                AsyncTab()
                    .tabItem {
                        Label(Localized.AsyncTab.title, systemImage: "list.dash")
                    }
            }
        }

    }
}
