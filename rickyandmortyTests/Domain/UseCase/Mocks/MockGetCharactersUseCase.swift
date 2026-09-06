import Foundation
@testable import rickyandmorty

final class MockGetCharactersUseCase: GetCharactersUseCase {
    var returnedCharacters: [Character] = []
    var error: Error?
    private(set) var executeCalls = 0
    private(set) var executeNextPageCalls = 0

    override func execute() async throws -> [Character] {
        executeCalls += 1
        if let error { throw error }
        return returnedCharacters
    }

    override func executeNextPage() async throws -> [Character] {
        executeNextPageCalls += 1
        if let error { throw error }
        return returnedCharacters
    }
}