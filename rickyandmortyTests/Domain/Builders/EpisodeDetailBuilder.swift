import Foundation
@testable import rickyandmorty

final class EpisodeDetailBuilder {
    var id: Int = 1
    var name: String = "Pilot"
    var episode: String = "S01E01"
    var airDate: String = "December 2, 2013"

    func withId(_ id: Int) -> Self { self.id = id; return self }
    func withName(_ name: String) -> Self { self.name = name; return self }
    func withEpisode(_ episode: String) -> Self { self.episode = episode; return self }
    func withAirDate(_ airDate: String) -> Self { self.airDate = airDate; return self }

    func build() -> EpisodeDetail {
        EpisodeDetail(id: id, name: name, episode: episode, airDate: airDate)
    }
}

func makeEpisodeDetail(_ block: (EpisodeDetailBuilder) -> Void = { _ in }) -> EpisodeDetail {
    let builder = EpisodeDetailBuilder()
    block(builder)
    return builder.build()
}