import Foundation

extension CharacterData {
    func toDomain() -> Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: SummaryLocation(id: originId ?? -1, name: originName),
            location: SummaryLocation(id: locationId ?? -1, name: locationName),
            image: image,
            episodeIds: episodeIds,
            created: created,
            isFavourite: isFavourite
        )
    }
}
