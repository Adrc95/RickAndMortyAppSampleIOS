import Factory
import Foundation

class GetCharacterByIdUseCase {

    @Injected(\.characterRepository) private var repository

    func execute(id: Int) async throws -> Character {
        try await repository.getCharacterDetail(id: id)
    }

    func executeCached(id: Int) async -> Character? {
        await repository.getCachedCharacter(id: id)
    }

    func executeRefresh(id: Int) async -> Character? {
        await repository.refreshCharacter(id: id)
    }
}