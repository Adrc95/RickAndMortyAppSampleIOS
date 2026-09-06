import Factory
import Foundation

final class SettingsPreferenceDataSourceImpl: SettingsPreferenceDataSource {

    @ObservationIgnored @Injected(\.userDefaults) private var userDefaults

    func getThemeMode() -> String {
        userDefaults.get(DataConstants.themeModeKey, as: String.self, default: DataConstants.themeModeDefault)
    }

    func setThemeMode(_ mode: String) {
        userDefaults.set(DataConstants.themeModeKey, value: mode)
    }
}
