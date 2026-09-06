import Factory
import Foundation

final class RemoteDataSourceImpl: RemoteDataSource {

    @Injected(\.characterService)
    private var characterService
    @Injected(\.locationService)
    private var locationService
    @Injected(\.episodeService)
    private var episodeService

    func getCharacters(page: Int) async throws -> CharactersResponse {
        try await characterService.getCharacters(page: page, name: nil, species: nil, gender: nil, status: nil)
    }

    func getCharacterDetail(id: Int) async throws -> CharacterDto {
        try await characterService.getCharacterDetail(id: id)
    }

    func searchCharacters(page: Int, name: String?, species: String?, gender: String?, status: String?) async throws -> CharactersResponse {
        try await characterService.getCharacters(page: page, name: name, species: species, gender: gender, status: status)
    }

    func getLocation(id: Int) async throws -> LocationDto {
        try await locationService.getLocation(id: id)
    }

    func getEpisodes(ids: [Int]) async throws -> [EpisodeDto] {
        try await episodeService.getEpisodes(ids: ids)
    }
}
