import Foundation

extension Character {
    func toDisplayModel() -> CharacterDisplayModel {
        CharacterDisplayModel(
            id: id,
            name: name,
            status: CharacterStatusDisplayModel.from(status),
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            originDetail: nil,
            location: location,
            locationDetail: nil,
            image: image,
            episodeIds: episodeIds,
            isFavourite: isFavourite
        )
    }
}
