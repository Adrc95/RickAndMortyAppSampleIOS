import Foundation
import OSLog

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier ?? "com.napptilus.sample.rickyandmorty"

    static let network = Logger(subsystem: subsystem, category: "Network")
    static let database = Logger(subsystem: subsystem, category: "Database")
    static let app = Logger(subsystem: subsystem, category: "App")
}
