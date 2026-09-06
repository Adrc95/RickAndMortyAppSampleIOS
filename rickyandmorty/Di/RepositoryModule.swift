import Factory
import Foundation

extension Container {

    var characterRepository: Factory<CharacterRepository> {
        self { CharacterRepositoryImpl() }.singleton
    }

    var locationRepository: Factory<LocationRepository> {
        self { LocationRepositoryImpl() }.singleton
    }

    var episodeRepository: Factory<EpisodeRepository> {
        self { EpisodeRepositoryImpl() }.singleton
    }

    var settingsRepository: Factory<SettingsRepository> {
        self { SettingsRepositoryImpl() }.singleton
    }
}
