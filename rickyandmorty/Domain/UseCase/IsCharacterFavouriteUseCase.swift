import Factory
import Foundation

class IsCharacterFavouriteUseCase {

    @Injected(\.characterRepository) private var repository

    func execute(characterId: Int) async -> Bool {
        await repository.isFavourite(characterId: characterId)
    }
}
