import Foundation

protocol SettingsRepository {
    func getThemeMode() -> ThemeMode
    func setThemeMode(_ mode: ThemeMode)
}
