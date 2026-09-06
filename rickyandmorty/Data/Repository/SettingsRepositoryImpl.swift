import Factory
import Foundation

final class SettingsRepositoryImpl: SettingsRepository {

    @Injected(\.settingsPreferenceDataSource) private var settingsDataSource

    func getThemeMode() -> ThemeMode {
        let raw = settingsDataSource.getThemeMode()
        return ThemeMode.from(raw)
    }

    func setThemeMode(_ mode: ThemeMode) {
        settingsDataSource.setThemeMode(mode.rawValue)
    }
}
