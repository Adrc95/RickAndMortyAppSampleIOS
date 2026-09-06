import Foundation
@testable import rickyandmorty

final class MockGetEpisodesByIdsUseCase: GetEpisodesByIdsUseCase {
    var returnedEpisodes: [EpisodeDetail] = []
    var error: Error?
    private(set) var calls: [(characterId: Int, episodeIds: [Int])] = []

    override func execute(characterId: Int, episodeIds: [Int]) async throws -> [EpisodeDetail] {
        calls.append((characterId, episodeIds))
        if let error { throw error }
        return returnedEpisodes
    }
}