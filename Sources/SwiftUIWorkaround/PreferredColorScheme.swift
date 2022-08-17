import SwiftUI

extension Workaround {
    /// https://stackoverflow.com/questions/65798263/swiftui-how-to-let-the-user-set-the-app-appearance-in-real-time-w-options-lig
    public func preferredColorScheme(_ colorScheme: Binding<ColorScheme?>) -> some View {
        base.modifier(PreferredColorSchemeModifier(colorScheme: colorScheme))
    }
}

struct PreferredColorSchemeModifier: ViewModifier {
    @Environment(\.scenePhase) var scenePhase
    @Binding var colorScheme: ColorScheme?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: colorScheme) { newValue in
                setUserInterfaceStyle(newValue.userInterfaceStyle)
            }
            .onChange(of: scenePhase) { _ in
                setUserInterfaceStyle(colorScheme.userInterfaceStyle)
            }
    }
    
    func setUserInterfaceStyle(_ interfaceStyle: UIUserInterfaceStyle) {
        UIApplication
            .shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .forEach { scene in
                scene.keyWindow?.overrideUserInterfaceStyle = interfaceStyle
            }
    }
}

extension Optional where Wrapped == ColorScheme {
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return .unspecified
        }
    }
}
