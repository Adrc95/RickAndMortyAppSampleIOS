import Factory
import Foundation

final class EpisodeRepositoryImpl: EpisodeRepository {

    @Injected(\.remoteDataSource) private var remoteDataSource
    @Injected(\.localDataSource) private var localDataSource

    func getEpisodes(characterId: Int, episodeIds: [Int]) async throws -> [EpisodeDetail] {
        let cached: [EpisodeData] = await MainActor.run { localDataSource.getEpisodes(ids: episodeIds) }
        if cached.count == episodeIds.count {
            return cached.map { $0.toDomain() }
        }

        let dtos = try await remoteDataSource.getEpisodes(ids: episodeIds)
        let entities = dtos.map { $0.toData() }
        await MainActor.run { localDataSource.saveEpisodes(entities) }
        return dtos.map { $0.toDomain() }
    }
}
