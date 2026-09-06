import Foundation

extension Error {
    func toAppError() -> AppError {
        if let networkError = self as? NetworkError {
            switch networkError {
            case .connectivity:
                return .connectivity
            case .serverError(let code):
                return .server(code)
            default:
                return .unknown(networkError.localizedDescription)
            }
        }

        if let urlError = self as? URLError,
           urlError.code == .notConnectedToInternet {
            return .connectivity
        }

        return .unknown(self.localizedDescription)
    }
}
