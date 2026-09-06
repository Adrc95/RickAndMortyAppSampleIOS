import Foundation
@testable import rickyandmorty

final class MockGetCharacterByIdUseCase: GetCharacterByIdUseCase {
    var returnedDetail: Character?
    var error: Error?
    var cached: Character?
    var refreshed: Character?
    private(set) var executeCalls: [Int] = []

    override func execute(id: Int) async throws -> Character {
        executeCalls.append(id)
        if let error { throw error }
        guard let returnedDetail else {
            throw NetworkError.connectivity
        }
        return returnedDetail
    }

    override func executeCached(id: Int) async -> Character? {
        cached
    }

    override func executeRefresh(id: Int) async -> Character? {
        refreshed
    }
}