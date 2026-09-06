import Foundation
import SwiftData

@Model
final class CharacterData {
    @Attribute(.unique) var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var originName: String
    var originId: Int?
    var locationName: String
    var locationId: Int?
    var image: String
    var episodeIdsData: Data
    var created: String
    var isFavourite: Bool

    var episodeIds: [Int] {
        get {
            (try? JSONDecoder().decode([Int].self, from: episodeIdsData)) ?? []
        }
        set {
            episodeIdsData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }

    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        originName: String,
        originId: Int?,
        locationName: String,
        locationId: Int?,
        image: String,
        episodeIds: [Int],
        created: String,
        isFavourite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.originName = originName
        self.originId = originId
        self.locationName = locationName
        self.locationId = locationId
        self.image = image
        self.episodeIdsData = (try? JSONEncoder().encode(episodeIds)) ?? Data()
        self.created = created
        self.isFavourite = isFavourite
    }
}
