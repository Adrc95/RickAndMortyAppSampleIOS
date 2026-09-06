import Factory
import Foundation

@Observable
final class SettingsViewModel {

    @ObservationIgnored @Injected(\.getThemeModeUseCase) private var getThemeModeUseCase
    @ObservationIgnored @Injected(\.setThemeModeUseCase) private var setThemeModeUseCase
    @ObservationIgnored @Injected(\.appThemeStore) private var appThemeStore

    var themeMode: ThemeMode {
        get { appThemeStore.themeMode }
        set { appThemeStore.themeMode = newValue }
    }

    func loadThemeMode() {
        appThemeStore.themeMode = getThemeModeUseCase.execute()
    }

    func onThemeModeSelected(_ mode: ThemeMode) {
        appThemeStore.themeMode = mode
        setThemeModeUseCase.execute(mode: mode)
    }
}
