import Factory
import Foundation

class SetThemeModeUseCase {

    @Injected(\.settingsRepository) private var repository

    func execute(mode: ThemeMode) {
        repository.setThemeMode(mode)
    }
}
