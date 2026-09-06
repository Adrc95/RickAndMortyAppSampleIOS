import Foundation
@testable import rickyandmorty

final class CharacterDtoBuilder {
    var id: Int = 1
    var name: String = "Rick Sanchez"
    var status: String = "Alive"
    var species: String = "Human"
    var type: String = ""
    var gender: String = "Male"
    var origin: SummaryLocationDto = .init(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1")
    var location: SummaryLocationDto = .init(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3")
    var image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    var episode: [String] = [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2"
    ]
    var url: String = "https://rickandmortyapi.com/api/character/1"
    var created: String = "2017-11-04T18:48:46.250Z"

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withStatus(_ status: String) -> Self { self.status = status; return self }
    func withSpecies(_ species: String) -> Self { self.species = species; return self }
    func withType(_ type: String) -> Self { self.type = type; return self }
    func withGender(_ gender: String) -> Self { self.gender = gender; return self }
    func withOrigin(_ origin: SummaryLocationDto) -> Self { self.origin = origin; return self }
    func withLocation(_ location: SummaryLocationDto) -> Self { self.location = location; return self }
    func withImage(_ image: String) -> Self { self.image = image; return self }
    func withEpisode(_ episode: [String]) -> Self { self.episode = episode; return self }
    func withUrl(_ url: String) -> Self { self.url = url; return self }
    func withCreated(_ created: String) -> Self { self.created = created; return self }

    func build() -> CharacterDto {
        CharacterDto(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }
}

func makeCharacterDto(_ block: (CharacterDtoBuilder) -> Void = { _ in }) -> CharacterDto {
    let builder = CharacterDtoBuilder()
    block(builder)
    return builder.build()
}