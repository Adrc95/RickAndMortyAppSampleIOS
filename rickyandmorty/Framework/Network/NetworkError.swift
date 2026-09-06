import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case connectivity
    case serverError(statusCode: Int)
    case decodingFailed(Error)
    case unknown(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .connectivity:
            return "No internet connection"
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
