import Factory
import Foundation

func getViewModel() -> HomeViewModel {
    Container.shared.homeViewModel()
}

func getViewModel() -> SettingsViewModel {
    Container.shared.settingsViewModel()
}

func getViewModel(characterId: Int) -> DetailViewModel {
    Container.shared.detailViewModel(characterId)
}
