import Factory
import Foundation

extension Container {

    var getCharactersUseCase: Factory<GetCharactersUseCase> {
        self { GetCharactersUseCase() }.unique
    }

    var getCharacterByIdUseCase: Factory<GetCharacterByIdUseCase> {
        self { GetCharacterByIdUseCase() }.unique
    }

    var searchCharactersUseCase: Factory<SearchCharactersUseCase> {
        self { SearchCharactersUseCase() }.unique
    }

    var getLocationByIdUseCase: Factory<GetLocationByIdUseCase> {
        self { GetLocationByIdUseCase() }.unique
    }

    var getEpisodesByIdsUseCase: Factory<GetEpisodesByIdsUseCase> {
        self { GetEpisodesByIdsUseCase() }.unique
    }

    var toggleFavouriteUseCase: Factory<ToggleFavouriteUseCase> {
        self { ToggleFavouriteUseCase() }.unique
    }

    var isCharacterFavouriteUseCase: Factory<IsCharacterFavouriteUseCase> {
        self { IsCharacterFavouriteUseCase() }.unique
    }

    var getFavouriteCharacterIdsUseCase: Factory<GetFavouriteCharacterIdsUseCase> {
        self { GetFavouriteCharacterIdsUseCase() }.unique
    }

    var getFilterGroupsUseCase: Factory<GetFilterGroupsUseCase> {
        self { GetFilterGroupsUseCase() }.unique
    }

    var getThemeModeUseCase: Factory<GetThemeModeUseCase> {
        self { GetThemeModeUseCase() }.unique
    }

    var setThemeModeUseCase: Factory<SetThemeModeUseCase> {
        self { SetThemeModeUseCase() }.unique
    }
}
