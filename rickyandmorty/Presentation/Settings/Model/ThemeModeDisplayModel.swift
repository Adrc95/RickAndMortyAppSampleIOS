import SwiftUI

enum ThemeModeDisplayModel: Hashable {
    case light
    case dark
    case system

    var text: String {
        switch self {
        case .light: "light_mode".getString()
        case .dark: "dark_mode".getString()
        case .system: "system_mode".getString()
        }
    }

    var icon: AppIcon {
        switch self {
        case .light: .lightMode
        case .dark: .darkMode
        case .system: .systemMode
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: nil
        }
    }

    var toDomain: ThemeMode {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: .system
        }
    }

    static func from(_ theme: ThemeMode) -> ThemeModeDisplayModel {
        switch theme {
        case .light: .light
        case .dark: .dark
        case .system: .system
        }
    }
}
