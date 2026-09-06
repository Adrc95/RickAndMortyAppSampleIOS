import Foundation
@testable import rickyandmorty

final class EpisodeDtoBuilder {
    var id: Int = 1
    var name: String = "Pilot"
    var airDate: String = "December 2, 2013"
    var episode: String = "S01E01"
    var characters: [String] = []
    var url: String = "https://rickandmortyapi.com/api/episode/1"
    var created: String = "2017-11-10T12:56:33.798Z"

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withAirDate(_ airDate: String) -> Self { self.airDate = airDate; return self }
    func withEpisode(_ episode: String) -> Self { self.episode = episode; return self }
    func withCharacters(_ characters: [String]) -> Self { self.characters = characters; return self }
    func withUrl(_ url: String) -> Self { self.url = url; return self }
    func withCreated(_ created: String) -> Self { self.created = created; return self }

    func build() -> EpisodeDto {
        EpisodeDto(
            id: id,
            name: name,
            airDate: airDate,
            episode: episode,
            characters: characters,
            url: url,
            created: created
        )
    }
}

func makeEpisodeDto(_ block: (EpisodeDtoBuilder) -> Void = { _ in }) -> EpisodeDto {
    let builder = EpisodeDtoBuilder()
    block(builder)
    return builder.build()
}