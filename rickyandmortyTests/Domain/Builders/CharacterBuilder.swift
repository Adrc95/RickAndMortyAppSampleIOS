import Foundation
@testable import rickyandmorty

final class CharacterBuilder {
    var id: Int = 1
    var name: String = "Rick Sanchez"
    var status: String = "Alive"
    var species: String = "Human"
    var type: String = ""
    var gender: String = "Male"
    var origin: SummaryLocation = .init(id: 1, name: "Earth (C-137)")
    var location: SummaryLocation = .init(id: 3, name: "Citadel of Ricks")
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
    func withOrigin(_ origin: SummaryLocation) -> Self { self.origin = origin; return self }
    func withLocation(_ location: SummaryLocation) -> Self { self.location = location; return self }
    func withImage(_ image: String) -> Self { self.image = image; return self }
    func withEpisodeIds(_ episodeIds: [Int]) -> Self { self.episodeIds = episodeIds; return self }
    func withCreated(_ created: String) -> Self { self.created = created; return self }
    func withIsFavourite(_ isFavourite: Bool) -> Self { self.isFavourite = isFavourite; return self }

    func build() -> Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episodeIds: episodeIds,
            created: created,
            isFavourite: isFavourite
        )
    }
}

func makeCharacter(_ block: (CharacterBuilder) -> Void = { _ in }) -> Character {
    let builder = CharacterBuilder()
    block(builder)
    return builder.build()
}