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
        self.action = { }
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
                }
                isBusy = false
            } else {
                action()
            }
        }
               , label: label)
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
}

public extension StandardButton where Label == Image {
    init(status: StandardButtonStyle.Status, customImageName: String, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Image(customImageName)
        }
    }

    init(status: StandardButtonStyle.Status, customImage: UIImage, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Image(uiImage: customImage)
        }
    }

    init(status: StandardButtonStyle.Status, systemImageName: String, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
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
        configuration.label
            .highPriorityGesture(LongPressGesture())
            .padding(8)
            .frame(maxHeight: 44)
            .frame(maxWidth: .infinity)
            .background(isPrimary ? buttonTheme.colors.primaryColor : buttonTheme.colors.secondaryColor)
            .foregroundStyle(isPrimary ? buttonTheme.colors.secondaryColor : buttonTheme.colors.primaryColor)
            .clipShape(.capsule(style: .continuous))
            .buttonBorderShape(.capsule)
            .overlay(
                Capsule(style: .continuous)
                    .inset(by: 0)
                    .strokeBorder(isPrimary ? .clear : buttonTheme.colors.primaryColor, lineWidth: 2))
            .opacity(isEnabled ? 1.0 : 0.4)
            .scaleEffect(configuration.isPressed ? 2.8 : 1.0)
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
