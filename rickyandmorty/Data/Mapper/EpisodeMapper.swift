import Foundation

extension EpisodeDto {
    func toDomain() -> EpisodeDetail {
        EpisodeDetail(
            id: id,
            name: name,
            episode: episode,
            airDate: airDate
        )
    }

    func toData() -> EpisodeData {
        EpisodeData(
            id: id,
            name: name,
            episode: episode,
            airDate: airDate
        )
    }
}

extension EpisodeData {
    func toDomain() -> EpisodeDetail {
        EpisodeDetail(
            id: id,
            name: name,
            episode: episode,
            airDate: airDate
        )
    }
}
