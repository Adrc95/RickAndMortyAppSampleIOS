import Factory
import Foundation

protocol CharacterService {
    func getCharacters(page: Int, name: String?, species: String?, gender: String?, status: String?) async throws -> CharactersResponse
    func getCharacterDetail(id: Int) async throws -> CharacterDto
}

final class CharacterServiceImpl: CharacterService {

    @Injected(\.apiClient) private var apiClient

    func getCharacters(page: Int, name: String? = nil, species: String? = nil, gender: String? = nil, status: String? = nil) async throws -> CharactersResponse {
        try await apiClient.request(CharacterEndpoint.getCharacters(page: page, name: name, species: species, gender: gender, status: status))
    }

    func getCharacterDetail(id: Int) async throws -> CharacterDto {
        try await apiClient.request(CharacterEndpoint.getCharacterDetail(id: id))
    }
}

enum CharacterEndpoint: Endpoint {
    case getCharacters(page: Int, name: String?, species: String?, gender: String?, status: String?)
    case getCharacterDetail(id: Int)

    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        case .getCharacterDetail(let id):
            return "/character/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case let .getCharacters(page, name, species, gender, status):
            var items = [URLQueryItem(name: "page", value: "\(page)")]
            if let name, !name.isEmpty {
                items.append(URLQueryItem(name: "name", value: name))
            }
            if let species, !species.isEmpty {
                items.append(URLQueryItem(name: "species", value: species))
            }
            if let gender, !gender.isEmpty {
                items.append(URLQueryItem(name: "gender", value: gender))
            }
            if let status, !status.isEmpty {
                items.append(URLQueryItem(name: "status", value: status))
            }
            return items
        case .getCharacterDetail:
            return nil
        }
    }
}
