import Foundation
@testable import rickyandmorty

final class MockSearchCharactersUseCase: SearchCharactersUseCase {
    var returnedPage: CharacterPage = CharacterPage(characters: [], hasNext: false)
    var error: Error?
    private(set) var calls: [SearchCall] = []

    var lastCall: SearchCall? {
        calls.last
    }

    override func execute(name: String?, species: String?, gender: String?, status: String?, page: Int) async throws -> CharacterPage {
        calls.append(SearchCall(name: name, species: species, gender: gender, status: status, page: page))
        if let error { throw error }
        return returnedPage
    }
}