import Factory
import Foundation
import Kingfisher

extension Container {

    var imageCache: Factory<Bool> {
        self {
            ImageCacheConfig.configureDefault()
            return true
        }.singleton
    }

    var apiClient: Factory<APIClient> {
        self { APIClient() }.singleton
    }

    var characterService: Factory<CharacterService> {
        self { CharacterServiceImpl() }.singleton
    }

    var locationService: Factory<LocationService> {
        self { LocationServiceImpl() }.singleton
    }

    var episodeService: Factory<EpisodeService> {
        self { EpisodeServiceImpl() }.singleton
    }
}
