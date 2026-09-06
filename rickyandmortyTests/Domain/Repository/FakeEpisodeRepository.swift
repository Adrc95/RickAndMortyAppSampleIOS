import Foundation
@testable import rickyandmorty

final class FakeEpisodeRepository: EpisodeRepository {

    private(set) var episodes: [Int: [EpisodeDetail]] = [:]
    var error: Error?

    func setEpisodes(_ episodes: [EpisodeDetail], for characterId: Int) {
        self.episodes[characterId] = episodes
    }

    func getEpisodes(characterId: Int, episodeIds: [Int]) async throws -> [EpisodeDetail] {
        if let error { throw error }
        return episodes[characterId] ?? []
    }
}