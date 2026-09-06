import Factory
import Foundation

class GetEpisodesByIdsUseCase {

    @Injected(\.episodeRepository) private var repository

    func execute(characterId: Int, episodeIds: [Int]) async throws -> [EpisodeDetail] {
        try await repository.getEpisodes(characterId: characterId, episodeIds: episodeIds)
    }
}
