import SwiftUI

extension Color {
    static let white = Color(hex: 0xFFFFFF)
    static let black = Color(hex: 0x000000)
    static let slate50 = Color(hex: 0xF7F9FB)
    static let slate100 = Color(hex: 0xF2F4F6)
    static let slate200 = Color(hex: 0xECEEF0)
    static let slate300 = Color(hex: 0xE6E8EA)
    static let slate400 = Color(hex: 0xE0E3E5)
    static let slate500 = Color(hex: 0xC6C6CD)
    static let slate600 = Color(hex: 0x76777D)
    static let slate700 = Color(hex: 0x565E74)
    static let slate800 = Color(hex: 0x45464D)
    static let slate900 = Color(hex: 0x2D3133)
    static let slate950 = Color(hex: 0x191C1E)
    static let neutral50 = Color(hex: 0xEFF1F3)
    static let neutral100 = Color(hex: 0xD8DADC)
    static let cyan50 = Color(hex: 0xC4E7FF)
    static let cyan100 = Color(hex: 0x7BD0FF)
    static let cyan200 = Color(hex: 0x40C2FD)
    static let cyan300 = Color(hex: 0x38BDF8)
    static let cyan700 = Color(hex: 0x00668A)
    static let cyan800 = Color(hex: 0x004D6A)
    static let cyan950 = Color(hex: 0x001E2C)
    static let blue50 = Color(hex: 0xDAE2FD)
    static let blue100 = Color(hex: 0xD3E4FE)
    static let blueGray200 = Color(hex: 0xB7C8E1)
    static let blueGray300 = Color(hex: 0xBEC6E0)
    static let blueGray500 = Color(hex: 0x7C839B)
    static let blueGray600 = Color(hex: 0x75859D)
    static let navy700 = Color(hex: 0x38485D)
    static let navy800 = Color(hex: 0x3F465C)
    static let navy900 = Color(hex: 0x131B2E)
    static let navy950 = Color(hex: 0x0B1C30)
    static let red100 = Color(hex: 0xFFDAD6)
    static let red200 = Color(hex: 0xFFB4AB)
    static let red700 = Color(hex: 0xBA1A1A)
    static let red900 = Color(hex: 0x93000A)
    static let red950 = Color(hex: 0x690005)
    static let darkBackground = Color(hex: 0x0F1113)
    static let darkSurface = Color(hex: 0x191C1E)
    static let darkSurfaceLowest = Color(hex: 0x0C0E10)
    static let darkTextPrimary = Color(hex: 0xF1F3F5)
    static let darkTextSecondary = Color(hex: 0xBFC3C8)
    static let darkBorder = Color(hex: 0x303338)
    static let green500 = Color(hex: 0x22C55E)
    static let onSurfaceVariant = Color(hex: 0x49454F)
    static let onSurfaceVariantDark = Color(hex: 0xCAC4D0)
}

extension Color {
    static func themeBackground(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkBackground : .slate50
    }

    static func themeSurface(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkSurface : .slate50
    }

    static func themeSurfaceContainerLowest(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkSurfaceLowest : .white
    }

    static func themeSurfaceContainer(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .slate800 : .slate200
    }

    static func themeOnSurface(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkTextPrimary : .slate950
    }

    static func themeOnSurfaceVariant(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkTextSecondary : .slate800
    }

    static func themePrimary(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .blueGray300 : .black
    }

    static func themeOutlineVariant(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .darkBorder : .slate500
    }

    static func themeError(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .red200 : .red700
    }

    static func themeOnErrorContainer(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? .red100 : .red900
    }
}

extension ColorScheme {
    var isDark: Bool {
        self == .dark
    }
}
