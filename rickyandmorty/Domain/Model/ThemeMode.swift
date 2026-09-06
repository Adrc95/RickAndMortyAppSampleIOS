enum ThemeMode: String {
    case light
    case dark
    case system

    static func from(_ value: String) -> ThemeMode {
        ThemeMode(rawValue: value) ?? .system
    }
}