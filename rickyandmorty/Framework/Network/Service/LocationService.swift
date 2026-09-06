import Factory
import Foundation

protocol LocationService {
    func getLocation(id: Int) async throws -> LocationDto
}

final class LocationServiceImpl: LocationService {

    @Injected(\.apiClient) private var apiClient

    func getLocation(id: Int) async throws -> LocationDto {
        try await apiClient.request(LocationEndpoint.getLocation(id: id))
    }
}

enum LocationEndpoint: Endpoint {
    case getLocation(id: Int)

    var path: String {
        switch self {
        case .getLocation(let id):
            return "/location/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
}
