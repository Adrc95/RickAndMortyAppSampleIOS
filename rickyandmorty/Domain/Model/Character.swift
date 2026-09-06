struct Character {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SummaryLocation
    let location: SummaryLocation
    let image: String
    let episodeIds: [Int]
    let created: String
    let isFavourite: Bool

    init(id: Int, name: String, status: String, species: String, type: String, gender: String,
         origin: SummaryLocation, location: SummaryLocation, image: String, episodeIds: [Int],
         created: String, isFavourite: Bool = false) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episodeIds = episodeIds
        self.created = created
        self.isFavourite = isFavourite
    }
}
