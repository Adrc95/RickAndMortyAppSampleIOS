import Factory
import Foundation

@Observable
final class DetailViewModel {

    struct UIState {
        var isLoading: Bool = true
        var character: CharacterDisplayModel? = nil
        var error: AppError? = nil
    }

    @ObservationIgnored @Injected(\.getCharacterByIdUseCase) private var getCharacterByIdUseCase
    @ObservationIgnored @Injected(\.getLocationByIdUseCase) private var getLocationByIdUseCase
    @ObservationIgnored @Injected(\.getEpisodesByIdsUseCase) private var getEpisodesByIdsUseCase
    @ObservationIgnored @Injected(\.isCharacterFavouriteUseCase) private var isCharacterFavouriteUseCase
    @ObservationIgnored @Injected(\.toggleFavouriteUseCase) private var toggleFavouriteUseCase

    var uiState = UIState()

    private let characterId: Int

    private var refreshTask: Task<Void, Never>?

    init(characterId: Int) {
        self.characterId = characterId
    }

    func loadCharacter() async {
        uiState.error = nil
        refreshTask?.cancel()

        let cached = await getCharacterByIdUseCase.executeCached(id: characterId)

        if let cached {
            uiState.character = await buildDisplayModel(from: cached)
            uiState.isLoading = false
            refreshInBackground()
            return
        }

        uiState.isLoading = true

        do {
            let characterDomain = try await getCharacterByIdUseCase.execute(id: characterId)
            let displayModel = await buildDisplayModel(from: characterDomain)
            uiState.character = displayModel
            uiState.error = nil
        } catch {
            uiState.error = error.toAppError()
        }

        uiState.isLoading = false
    }

    func onToggleFavourite() async {
        try? await toggleFavouriteUseCase.execute(characterId: characterId)
        if var updated = uiState.character {
            updated.isFavourite.toggle()
            uiState.character = updated
        }
    }

    private func refreshInBackground() {
        refreshTask = Task { [characterId] in
            guard let fresh = await getCharacterByIdUseCase.executeRefresh(id: characterId) else { return }
            guard !Task.isCancelled else { return }
            let displayModel = await buildDisplayModel(from: fresh)
            guard !Task.isCancelled else { return }
            uiState.character = displayModel
            uiState.isLoading = false
        }
    }

    private func buildDisplayModel(from characterDomain: Character) async -> CharacterDisplayModel {
        let locationUseCase = getLocationByIdUseCase
        let episodesUseCase = getEpisodesByIdsUseCase

        async let originDetail = locationUseCase.execute(
            characterId: characterId,
            locationId: characterDomain.origin.id,
            isOrigin: true
        )
        async let locationDetail = locationUseCase.execute(
            characterId: characterId,
            locationId: characterDomain.location.id,
            isOrigin: false
        )
        async let episodes = episodesUseCase.execute(
            characterId: characterId,
            episodeIds: characterDomain.episodeIds
        )

        let origin = (try? await originDetail) ?? nil
        let location = (try? await locationDetail) ?? nil
        let episodeDetails = (try? await episodes) ?? []

        let isFav = await isCharacterFavouriteUseCase.execute(characterId: characterId)

        return CharacterDisplayModel(
            id: characterDomain.id,
            name: characterDomain.name,
            status: CharacterStatusDisplayModel.from(characterDomain.status),
            species: characterDomain.species,
            type: characterDomain.type,
            gender: characterDomain.gender,
            origin: characterDomain.origin,
            originDetail: origin,
            location: characterDomain.location,
            locationDetail: location,
            image: characterDomain.image,
            episodeIds: characterDomain.episodeIds,
            episodeDetails: episodeDetails,
            isFavourite: isFav
        )
    }
}
