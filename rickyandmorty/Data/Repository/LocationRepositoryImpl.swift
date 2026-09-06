import Factory
import Foundation

final class LocationRepositoryImpl: LocationRepository {

    @Injected(\.remoteDataSource) private var remoteDataSource
    @Injected(\.localDataSource) private var localDataSource

    func getLocation(characterId: Int, locationId: Int, isOrigin: Bool) async throws -> LocationDetail? {
        let cached: LocationData? = await MainActor.run { localDataSource.getLocation(id: locationId) }
        if let cached {
            return cached.toDomain()
        }

        let dto = try await remoteDataSource.getLocation(id: locationId)
        let entity = dto.toData()
        await MainActor.run { localDataSource.saveLocation(entity) }
        return dto.toDomain()
    }
}
