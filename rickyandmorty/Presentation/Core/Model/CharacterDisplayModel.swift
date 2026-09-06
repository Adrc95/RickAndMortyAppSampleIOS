import Foundation

struct CharacterDisplayModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let status: CharacterStatusDisplayModel
    let species: String
    let type: String
    let gender: String
    let origin: SummaryLocation
    let originDetail: LocationDetail?
    let location: SummaryLocation
    let locationDetail: LocationDetail?
    let image: String
    let episodeIds: [Int]
    var episodeDetails: [EpisodeDetail]
    var isFavourite: Bool

    init(id: Int, name: String, status: CharacterStatusDisplayModel, species: String,
         type: String, gender: String, origin: SummaryLocation, originDetail: LocationDetail? = nil,
         location: SummaryLocation, locationDetail: LocationDetail? = nil, image: String,
         episodeIds: [Int], episodeDetails: [EpisodeDetail] = [], isFavourite: Bool = false) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.originDetail = originDetail
        self.location = location
        self.locationDetail = locationDetail
        self.image = image
        self.episodeIds = episodeIds
        self.episodeDetails = episodeDetails
        self.isFavourite = isFavourite
    }

    static func == (lhs: CharacterDisplayModel, rhs: CharacterDisplayModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.isFavourite == rhs.isFavourite &&
        lhs.episodeDetails == rhs.episodeDetails
    }
}
