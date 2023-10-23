//
//  StandardButton.swift
//  
//
//  Created by Andrew Winn on 10/22/23.
//

import SwiftUI

// MARK: -
/// A standard styled button that is used with common CTAs repeatedly through out the app. e.g. "Confirm," "Cancel," or "Submit" buttons.
///
/// The button handles it's own styled appearance based on the ``ButtonTheme`` in the current view environment. So custom themes can be applied to change its appearance with the ``buttonStyle(_:)-1waku`` modifier.
///
/// Can be used with either a synchronous button action or an asynchronous button action based on the initializer that is used. When performing an asynchronous action, the button displays a `ProgressView` in place of the button `label`.
public struct StandardButton<Label: View>: View {

    // MARK: - Public Properties
    let status: StandardButtonStyle.Status
    var action: () -> Void
    let asyncAction:  (() async -> Void)?
    @ViewBuilder var label: () -> Label

    // MARK: - Private Properties
    @State private var isBusy: Bool = false

    // MARK: - Initialization
    /// Creates a standard styled button with the specified status, synchronous action, and label view.
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - action: The synchronous action to perform when the button is tapped.
    ///   - label: The view to use as the button's label.
    public init(status: StandardButtonStyle.Status, action: @escaping () -> Void, label: @escaping () -> Label) {
        self.status = status
        self.action = action
        self.asyncAction = nil
        self.label = label
    }
    
    /// Creates a standard styled button with the specified status, asynchronous action, and label view.
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - asyncAction: The asynchronous action to perform when the button is tapped.
    ///   - label: The view to use as the button's label.
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
    /// Creates a standard styled button with the specified status, synchronous action, and title key for use in a Text() label view.
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - titleKey: `LocalizedStringKey` used to generate the button's Text() label view.
    ///   - action: The synchronous action to perform when the button is tapped.
    init(status: StandardButtonStyle.Status, _ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Text(titleKey)
        }
    }
    
    /// Creates a standard styled button with the specified status, asynchronous action, and title key for use in a Text() label view.
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - titleKey: `LocalizedStringKey` used to generate the button's Text() label view.
    ///   - asyncAction: The asynchronous action to perform when the button is tapped.
    init(status: StandardButtonStyle.Status, _ titleKey: LocalizedStringKey, asyncAction: @escaping () async -> Void) {
        self.init(status: status, asyncAction: asyncAction) {
            Text(titleKey)
        }
    }
}

public extension StandardButton where Label == Image {
    /// Creates a standard styled button with the specified status, synchronous action, and system image name for use in a Image() label view
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - systemImageName: The name of the system image to be used for the button's Image() label.
    ///   - action: The synchronous action to perform when the button is tapped.
    init(status: StandardButtonStyle.Status, systemImageName: String, action: @escaping () -> Void) {
        self.init(status: status, action: action) {
            Image(systemName: systemImageName)
        }
    }
    
     /// Creates a standard styled button with the specified status, asynchronous action, and system image name for use in a Image() label view
    /// - Parameters:
    ///   - status: The ``StandardButtonStyle/Status`` of the button. Used for styling the button.
    ///   - systemImageName: The name of the system image to be used for the button's Image() label.
    ///   - asyncAction: The asynchronous action to perform when the button is tapped.
    init(status: StandardButtonStyle.Status, systemImageName: String, asyncAction: @escaping () async -> Void) {
        self.init(status: status, asyncAction: asyncAction) {
            Image(systemName: systemImageName)
        }
    }
}

/// A button style that is used with common CTAs repeatedly through out the app. e.g. "Confirm," "Cancel," or "Submit" buttons. Similar to ``StandardButton``, but the style itself does not facilitate asynchronous button actions.
public struct StandardButtonStyle: ButtonStyle {
    // MARK: - Subtypes
    
    /// An enum that controls how a ``ButtonTheme``'s fonts and colors are applied.
    public enum Status {
        /// Button status for a primary standard styled button.
        case primary
        /// Button status for a primary standard styled button.
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
