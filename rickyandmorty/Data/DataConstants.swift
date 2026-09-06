import Foundation

final class DataConstants {
    private init() {}

    static let themeModeDefault = "system"
    static let themeModeKey = "theme_mode"
    static let dataStoreFile = "ricky_and_morty_settings"
    static let pageDelimiter = "page="
    static let ampersandDelimiter = "&"
    static let commaDelimiter = ","
    static let charactersResource = "characters"
    static let cacheTTLMillis: TimeInterval = 60 * 60 * 1000
    static let cacheTTLSeconds: TimeInterval = 60 * 60
    static let pagingSizeDefault = 20
    static let pagingInitialDefault = 60
    static let pagingPrefetchDefault = 5
    static let initialLoadPages = pagingInitialDefault / pagingSizeDefault
    static let pagingEnabledPlaceholderDefault = false
    static let error404 = 404
    static let defaultPage = 1
    static let defaultLastUpdated: TimeInterval = 0
}
