import Foundation
import Kingfisher

final class ImageCacheConfig {
    private init() {}

    static func configureDefault() {
        let cache = ImageCache.default
        cache.diskStorage.config.sizeLimit = 50 * 1024 * 1024
        cache.memoryStorage.config.totalCostLimit = Int(ProcessInfo.processInfo.physicalMemory / 4)
    }
}
