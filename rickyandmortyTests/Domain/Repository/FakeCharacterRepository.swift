import Foundation
@testable import rickyandmorty

struct SearchCall {
    let name: String?
    let species: String?
    let gender: String?
    let status: String?
    let page: Int
}

final class FakeCharacterRepository: CharacterRepository {

    private(set) var characters: [Character] = []
    private(set) var favourites: Set<Int> = []
    var detail: Character?
    var detailError: Error?
    var searchResult: CharacterPage?
    var nextPage: [Character] = []

    private(set) var getCharactersCalls = 0
    private(set) var loadNextPageCalls = 0
    private(set) var searchCalls: [SearchCall] = []
    private(set) var toggleFavouriteCalls: [Int] = []

    var lastSearchCall: SearchCall? {
        searchCalls.last
    }

    func setCharacters(_ characters: [Character]) {
        self.characters = characters
    }

    func setFavourite(_ characterId: Int, _ isFavourite: Bool) {
        if isFavourite { favourites.insert(characterId) } else { favourites.remove(characterId) }
    }

    func getCharacters() async throws -> [Character] {
        getCharactersCalls += 1
        return characters
    }

    func loadNextPage() async throws -> [Character] {
        loadNextPageCalls += 1
        return nextPage
    }

    func searchCharacters(name: String?, species: String?, gender: String?, status: String?, page: Int) async throws -> CharacterPage {
        searchCalls.append(SearchCall(name: name, species: species, gender: gender, status: status, page: page))
        return searchResult ?? CharacterPage(characters: characters, hasNext: false)
    }

    func getCharacterDetail(id: Int) async throws -> Character {
        if let detailError { throw detailError }
        guard let detail else {
            throw NetworkError.connectivity
        }
        return detail
    }

    func getCachedCharacter(id: Int) async -> Character? {
        nil
    }

    func refreshCharacter(id: Int) async -> Character? {
        detail
    }

    func isFavourite(characterId: Int) async -> Bool {
        favourites.contains(characterId)
    }

    func toggleFavourite(characterId: Int) async throws {
        toggleFavouriteCalls.append(characterId)
        if favourites.contains(characterId) {
            favourites.remove(characterId)
        } else {
            favourites.insert(characterId)
        }
    }

    func getFavouriteIds() async -> [Int] {
        Array(favourites)
    }
}