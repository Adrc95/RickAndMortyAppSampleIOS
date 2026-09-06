import Foundation
import SwiftData

@Model
final class EpisodeData {
    @Attribute(.unique) var id: Int
    var name: String
    var episode: String
    var airDate: String

    init(id: Int, name: String, episode: String, airDate: String) {
        self.id = id
        self.name = name
        self.episode = episode
        self.airDate = airDate
    }
}
