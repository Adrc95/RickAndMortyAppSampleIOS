import Factory
import Foundation

class GetLocationByIdUseCase {

    @Injected(\.locationRepository) private var repository

    func execute(characterId: Int, locationId: Int, isOrigin: Bool) async throws -> LocationDetail? {
        try await repository.getLocation(characterId: characterId, locationId: locationId, isOrigin: isOrigin)
    }
}
