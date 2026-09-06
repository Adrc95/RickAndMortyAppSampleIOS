import Foundation
@testable import rickyandmorty

final class CharacterDataBuilder {
    var id: Int = 1
    var name: String = "Rick Sanchez"
    var status: String = "Alive"
    var species: String = "Human"
    var type: String = ""
    var gender: String = "Male"
    var originName: String = "Earth (C-137)"
    var originId: Int? = 1
    var locationName: String = "Citadel of Ricks"
    var locationId: Int? = 3
    var image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    var episodeIds: [Int] = [1, 2]
    var created: String = "2017-11-04T18:48:46.250Z"
    var isFavourite: Bool = false

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withStatus(_ status: String) -> Self { self.status = status; return self }
    func withSpecies(_ species: String) -> Self { self.species = species; return self }
    func withType(_ type: String) -> Self { self.type = type; return self }
    func withGender(_ gender: String) -> Self { self.gender = gender; return self }
    func withOriginName(_ originName: String) -> Self { self.originName = originName; return self }
    func withOriginId(_ originId: Int?) -> Self { self.originId = originId; return self }
    func withLocationName(_ locationName: String) -> Self { self.locationName = locationName; return self }
    func withLocationId(_ locationId: Int?) -> Self { self.locationId = locationId; return self }
    func withImage(_ image: String) -> Self { self.image = image; return self }
    func withEpisodeIds(_ episodeIds: [Int]) -> Self { self.episodeIds = episodeIds; return self }
    func withCreated(_ created: String) -> Self { self.created = created; return self }
    func withIsFavourite(_ isFavourite: Bool) -> Self { self.isFavourite = isFavourite; return self }

    func build() -> CharacterData {
        CharacterData(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            originName: originName,
            originId: originId,
            locationName: locationName,
            locationId: locationId,
            image: image,
            episodeIds: episodeIds,
            created: created,
            isFavourite: isFavourite
        )
    }
}

func makeCharacterData(_ block: (CharacterDataBuilder) -> Void = { _ in }) -> CharacterData {
    let builder = CharacterDataBuilder()
    block(builder)
    return builder.build()
}