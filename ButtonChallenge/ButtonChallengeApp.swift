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
                        Label("Standard", systemImage: "list.dash")
                    }
                DisabledTab()
                    .tabItem {
                        Label("Disabled", systemImage: "list.dash")
                    }
                AsyncTab()
                    .tabItem {
                        Label("Async", systemImage: "list.dash")
                    }
                DisabledAsyncTab()
                    .tabItem {
                        Label("Disabled Async", systemImage: "list.dash")
                    }
            }
        }

    }
}
