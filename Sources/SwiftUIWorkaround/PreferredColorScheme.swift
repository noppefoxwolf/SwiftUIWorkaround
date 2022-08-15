import SwiftUI

extension Workaround {
    /// https://stackoverflow.com/questions/65798263/swiftui-how-to-let-the-user-set-the-app-appearance-in-real-time-w-options-lig
    public func preferredColorScheme(_ colorScheme: Binding<ColorScheme?>) -> some View {
        base.modifier(PreferredColorSchemeModifier(colorScheme: colorScheme))
    }
}

struct PreferredColorSchemeModifier: ViewModifier {
    @Binding var colorScheme: ColorScheme?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: colorScheme) { newValue in
                UIApplication
                    .shared
                    .connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .forEach { scene in
                        scene.keyWindow?.overrideUserInterfaceStyle = newValue.userInterfaceStyle
                    }
            }
    }
}

extension Optional<ColorScheme> {
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
