import Foundation

enum AppError: Error, LocalizedError {
    case connectivity
    case server(Int)
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .connectivity:
            return "error_connectivity".getString()
        case .server(let code):
            return "error_server".getString(args: code)
        case .unknown(let message):
            return message.isEmpty ? "error_unknown".getString() : message
        }
    }
}
