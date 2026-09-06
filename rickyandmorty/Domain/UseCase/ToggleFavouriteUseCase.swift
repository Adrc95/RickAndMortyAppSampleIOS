import Factory
import Foundation

class ToggleFavouriteUseCase {

    @Injected(\.characterRepository) private var repository

    func execute(characterId: Int) async throws {
        try await repository.toggleFavourite(characterId: characterId)
    }
}
