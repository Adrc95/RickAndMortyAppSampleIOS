import Factory
import Foundation

class GetThemeModeUseCase {

    @Injected(\.settingsRepository) private var repository

    func execute() -> ThemeMode {
        repository.getThemeMode()
    }
}
