import Factory
import Foundation

extension Container {

    var homeViewModel: Factory<HomeViewModel> {
        self { HomeViewModel() }.unique
    }

    var settingsViewModel: Factory<SettingsViewModel> {
        self { SettingsViewModel() }.unique
    }

    var detailViewModel: ParameterFactory<Int, DetailViewModel> {
        self { characterId in DetailViewModel(characterId: characterId) }.unique
    }
}
