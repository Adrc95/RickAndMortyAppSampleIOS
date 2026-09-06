import Foundation
@testable import rickyandmorty

final class MockIsCharacterFavouriteUseCase: IsCharacterFavouriteUseCase {
    var returnedValue = false
    private(set) var calls: [Int] = []

    override func execute(characterId: Int) async -> Bool {
        calls.append(characterId)
        return returnedValue
    }
}