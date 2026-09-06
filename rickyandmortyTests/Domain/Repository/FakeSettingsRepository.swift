import Foundation
@testable import rickyandmorty

final class FakeSettingsRepository: SettingsRepository {

    private(set) var themeMode: ThemeMode = .system
    private(set) var setCalls: [ThemeMode] = []

    func setThemeModeValue(_ mode: ThemeMode) {
        themeMode = mode
    }

    func getThemeMode() -> ThemeMode {
        themeMode
    }

    func setThemeMode(_ mode: ThemeMode) {
        themeMode = mode
        setCalls.append(mode)
    }
}