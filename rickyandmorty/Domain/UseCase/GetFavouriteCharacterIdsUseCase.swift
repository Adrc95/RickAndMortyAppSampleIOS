import Factory
import Foundation

class GetFavouriteCharacterIdsUseCase {
    @Injected(\.characterRepository)
    private var repository

    func execute() async -> [Int] {
        await repository.getFavouriteIds()
    }
}