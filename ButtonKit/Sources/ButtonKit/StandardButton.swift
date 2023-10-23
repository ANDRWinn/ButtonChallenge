//
//  StandardButton.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

// MARK: -
public struct StandardButton<Label: View>: View {

    // MARK: - Public Properties
    let status: StandardButtonStyle.Status
    var action: () -> Void
    let asyncAction:  (() async -> Void)?
    @ViewBuilder var label: () -> Label

    // MARK: - Private Properties
    @State private var isBusy: Bool = false

    // MARK: - Initialization
    public init(status: StandardButtonStyle.Status, action: @escaping () -> Void, label: @escaping () -> Label) {
        self.status = status
        self.action = action
        self.asyncAction = nil
        self.label = label
    }

    public init(status: StandardButtonStyle.Status, asyncAction: @escaping () async -> Void, label: @escaping () -> Label) {
        self.status = status
        self.action = { assertionFailure("Synchronous action called using async action intializer") }
        self.asyncAction = asyncAction
        self.label = label
    }

    // MARK: - Body
    public var body: some View {
        Button(action: {
            if let asyncAction = self.asyncAction {
                isBusy = true
                Task {
                    await asyncAction()
                    isBusy = false
                }
            } else {
                action()
            }
        }
               , label: {
            ZStack {
                label().opacity(isBusy ? 0.01 : 1.0)
                if isBusy {
                    ProgressView()
                }
            }
        })
        .buttonStyle(StandardButtonStyle(status: status))
    }
}

// MARK: - Additional Initializers
public extension StandardButton where Label == Text {
    init(status: StandardButtonStyle.Status, _ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Text(titleKey)
        }
    }

    init(status: StandardButtonStyle.Status, _ titleKey: LocalizedStringKey, asyncAction: @escaping () async -> Void) {
        self.init(status: status, asyncAction: asyncAction) {
            Text(titleKey)
        }
    }
}

public extension StandardButton where Label == Image {
    init(status: StandardButtonStyle.Status, systemImageName: String, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Image(systemName: systemImageName)
        }
    }

    init(status: StandardButtonStyle.Status, systemImageName: String, asyncAction: @escaping () async -> Void) {
        self.init(status: status, asyncAction: asyncAction) {
            Image(systemName: systemImageName)
        }
    }
}

public struct StandardButtonStyle: ButtonStyle {
    // MARK: - Subtypes
    public enum Status {
        case primary
        case secondary
    }

    // MARK: - Properties
    let status: Status
    @State private var isPressing: Bool = false
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.buttonTheme) private var buttonTheme
    private var isPrimary: Bool { status == .primary }

    public func makeBody(configuration: Configuration) -> some View {
        var opacity: CGFloat {
            guard isEnabled else { return 0.4}
            return configuration.isPressed ? 0.8 : 1.0
        }

        configuration.label
            .padding(8)
            .frame(minHeight: 44)
            .frame(maxWidth: .infinity)
            .background(isPrimary ? buttonTheme.colors.primaryColor : buttonTheme.colors.secondaryColor)
            .foregroundStyle(isPrimary ? buttonTheme.colors.secondaryColor : buttonTheme.colors.primaryColor)
            .tint(isPrimary ? buttonTheme.colors.secondaryColor : buttonTheme.colors.primaryColor)
            .clipShape(.capsule(style: .continuous))
            .buttonBorderShape(.capsule)
            .overlay(
                Capsule(style: .continuous)
                    .strokeBorder(isPrimary ? .clear : buttonTheme.colors.primaryColor, lineWidth: 2))
            .opacity(opacity)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)

    }
}

#Preview {
    VStack {
        StandardButton(status: .primary, "Primary", action: { } )
        StandardButton(status: .secondary, "Secondary", action: { } )
    }
    .padding()
}
