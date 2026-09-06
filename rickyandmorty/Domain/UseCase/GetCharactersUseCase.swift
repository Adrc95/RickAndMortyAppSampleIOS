import Factory
import Foundation

class GetCharactersUseCase {

    @Injected(\.characterRepository) private var repository

    func execute() async throws -> [Character] {
        try await repository.getCharacters()
    }

    func executeNextPage() async throws -> [Character] {
        try await repository.loadNextPage()
    }
}
