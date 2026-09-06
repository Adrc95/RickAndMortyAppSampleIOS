import SwiftUI

struct ThemeModifier: ViewModifier {
    let themeMode: ThemeMode

    func body(content: Content) -> some View {
        content
            .preferredColorScheme(ThemeModeDisplayModel.from(themeMode).colorScheme)
    }
}

extension View {
    func themed(_ mode: ThemeMode) -> some View {
        modifier(ThemeModifier(themeMode: mode))
    }
}
