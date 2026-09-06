import Factory
import Foundation

class SearchCharactersUseCase {

    @Injected(\.characterRepository) private var repository

    func execute(name: String?, species: String?, gender: String?, status: String?, page: Int) async throws -> CharacterPage {
        try await repository.searchCharacters(name: name, species: species, gender: gender, status: status, page: page)
    }
}
