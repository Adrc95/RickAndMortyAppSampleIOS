import Foundation
import OSLog
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    var baseURL: URL {
        URL(string: NetworkConstants.baseURL)!
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}

final class APIClient {

    static let shared = APIClient()

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession? = nil) {
        if ProcessInfo.processInfo.arguments.contains("--ui-testing") {
            if let bundleId = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleId)
            }
            UITextField.appearance().clearButtonMode = .never
        }
        if let injectedSession = session {
            self.session = injectedSession
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = NetworkConstants.timeout
            configuration.timeoutIntervalForResource = NetworkConstants.timeout
            if ProcessInfo.processInfo.arguments.contains("--ui-testing") {
                configuration.protocolClasses = [MockURLProtocol.self]
                MockUIFixtures.install()
            }
            self.session = URLSession(configuration: configuration)
        }
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .useDefaultKeys
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = buildURL(for: endpoint) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.cachePolicy = .reloadRevalidatingCacheData

        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let urlString = url.absoluteString
        Logger.network.debug("-> \(endpoint.method.rawValue) \(urlString)")

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(
                    NSError(domain: "APIClient", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response type"])
                )
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                Logger.network.error("HTTP \(httpResponse.statusCode) \(urlString)")
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            do {
                let decoded: T = try decoder.decode(T.self, from: data)
                Logger.network.debug("<- \(httpResponse.statusCode) \(urlString)")
                return decoded
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } catch let error as NetworkError {
            Logger.network.error("\(error.localizedDescription) \(urlString)")
            throw error
        } catch let error as URLError where error.code == .notConnectedToInternet {
            Logger.network.error("No internet connection \(urlString)")
            throw NetworkError.connectivity
        } catch {
            Logger.network.error("Unknown error: \(error.localizedDescription) \(urlString)")
            throw NetworkError.unknown(error)
        }
    }

    private func buildURL(for endpoint: Endpoint) -> URL? {
        var components = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
