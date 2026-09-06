import Foundation
import SwiftData

@Model
final class PagingKeyData {
    @Attribute(.unique) var key: String
    var currentPage: Int
    var hasNextPage: Bool
    var lastRefreshTimestamp: Date

    init(key: String = "characters", currentPage: Int = 1, hasNextPage: Bool = true, lastRefreshTimestamp: Date = .now) {
        self.key = key
        self.currentPage = currentPage
        self.hasNextPage = hasNextPage
        self.lastRefreshTimestamp = lastRefreshTimestamp
    }

    var isCacheFresh: Bool {
        Date.now.timeIntervalSince(lastRefreshTimestamp) < DataConstants.cacheTTLSeconds
    }
}
