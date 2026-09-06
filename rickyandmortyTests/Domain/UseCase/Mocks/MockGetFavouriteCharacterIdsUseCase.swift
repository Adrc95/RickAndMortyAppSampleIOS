import Foundation
@testable import rickyandmorty

final class MockGetFavouriteCharacterIdsUseCase: GetFavouriteCharacterIdsUseCase {
    var returnedIds: [Int] = []
    private(set) var executeCalls = 0

    override func execute() async -> [Int] {
        executeCalls += 1
        return returnedIds
    }
}