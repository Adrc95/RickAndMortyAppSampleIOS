import Foundation

extension CharacterDto {
    func toData() -> CharacterData {
        let originId = origin.url.split(separator: "/").last.flatMap { Int($0) }
        let locationId = location.url.split(separator: "/").last.flatMap { Int($0) }
        let episodeIds = episode.compactMap { url in
            url.split(separator: "/").last.flatMap { Int($0) }
        }

        return CharacterData(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: origin.name,
            originId: originId,
            locationName: location.name,
            locationId: locationId,
            image: image,
            episodeIds: episodeIds,
            created: created
        )
    }

    func toDomain() -> Character {
        let originId = origin.url.split(separator: "/").last.flatMap { Int($0) }
        let locationId = location.url.split(separator: "/").last.flatMap { Int($0) }
        let episodeIds = episode.compactMap { url in
            url.split(separator: "/").last.flatMap { Int($0) }
        }

        return Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: SummaryLocation(id: originId ?? -1, name: origin.name),
            location: SummaryLocation(id: locationId ?? -1, name: location.name),
            image: image,
            episodeIds: episodeIds,
            created: created
        )
    }
}
