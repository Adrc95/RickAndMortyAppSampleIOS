import Foundation

protocol CharacterRepository {
    func getCharacters() async throws -> [Character]
    func loadNextPage() async throws -> [Character]
    func searchCharacters(name: String?, species: String?, gender: String?, status: String?, page: Int) async throws -> CharacterPage
    func getCharacterDetail(id: Int) async throws -> Character
    func getCachedCharacter(id: Int) async -> Character?
    func refreshCharacter(id: Int) async -> Character?
    func isFavourite(characterId: Int) async -> Bool
    func toggleFavourite(characterId: Int) async throws
    func getFavouriteIds() async -> [Int]
}
