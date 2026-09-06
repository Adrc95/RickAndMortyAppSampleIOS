import Foundation

protocol RemoteDataSource {
    func getCharacters(page: Int) async throws -> CharactersResponse
    func getCharacterDetail(id: Int) async throws -> CharacterDto
    func searchCharacters(page: Int, name: String?, species: String?, gender: String?, status: String?) async throws -> CharactersResponse
    func getLocation(id: Int) async throws -> LocationDto
    func getEpisodes(ids: [Int]) async throws -> [EpisodeDto]
}
