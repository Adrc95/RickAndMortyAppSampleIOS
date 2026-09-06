import Foundation
@testable import rickyandmorty

final class MockToggleFavouriteUseCase: ToggleFavouriteUseCase {
    var error: Error?
    private(set) var calls: [Int] = []

    override func execute(characterId: Int) async throws {
        calls.append(characterId)
        if let error { throw error }
    }
}