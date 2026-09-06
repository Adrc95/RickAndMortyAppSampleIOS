import Foundation

protocol EpisodeRepository {
    func getEpisodes(characterId: Int, episodeIds: [Int]) async throws -> [EpisodeDetail]
}
