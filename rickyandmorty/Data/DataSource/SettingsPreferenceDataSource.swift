import Foundation

protocol SettingsPreferenceDataSource {
    func getThemeMode() -> String
    func setThemeMode(_ mode: String)
}
