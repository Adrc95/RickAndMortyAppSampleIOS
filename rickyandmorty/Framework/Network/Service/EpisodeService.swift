import Factory
import Foundation

protocol EpisodeService {
    func getEpisodes(ids: [Int]) async throws -> [EpisodeDto]
}

final class EpisodeServiceImpl: EpisodeService {

    @Injected(\.apiClient) private var apiClient

    func getEpisodes(ids: [Int]) async throws -> [EpisodeDto] {
        try await apiClient.request(EpisodeEndpoint.getEpisodes(ids: ids))
    }
}

enum EpisodeEndpoint: Endpoint {
    case getEpisodes(ids: [Int])

    var path: String {
        switch self {
        case .getEpisodes(let ids):
            return "/episode/\(ids.map(String.init).joined(separator: ","))"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        nil
    }
}
