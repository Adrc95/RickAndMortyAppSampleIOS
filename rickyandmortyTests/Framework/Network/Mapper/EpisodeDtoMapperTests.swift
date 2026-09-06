import XCTest
@testable import rickyandmorty

final class EpisodeDtoMapperTests: XCTestCase {

    func `test_given_episode_dto_when_mapped_to_domain_then_returns_episode_detail`() {
        let dto = makeEpisodeDto {
            $0.withId(1)
            $0.withName("Pilot")
            $0.withEpisode("S01E01")
            $0.withAirDate("December 2, 2013")
        }
        let expected = makeEpisodeDetail {
            $0.withId(1)
            $0.withName("Pilot")
            $0.withEpisode("S01E01")
            $0.withAirDate("December 2, 2013")
        }

        XCTAssertEqual(dto.toDomain(), expected)
    }

    func `test_given_episode_dto_with_different_data_when_mapped_to_domain_then_returns_correct_values`() {
        let dto = makeEpisodeDto {
            $0.withId(25)
            $0.withName("The Wedding Squanchers")
            $0.withEpisode("S02E10")
            $0.withAirDate("October 4, 2015")
        }
        let expected = makeEpisodeDetail {
            $0.withId(25)
            $0.withName("The Wedding Squanchers")
            $0.withEpisode("S02E10")
            $0.withAirDate("October 4, 2015")
        }

        XCTAssertEqual(dto.toDomain(), expected)
    }

    func `test_given_episode_dto_when_mapped_to_data_then_maps_identity_fields`() {
        let data = makeEpisodeDto().toData()

        XCTAssertEqual(data.id, 1)
        XCTAssertEqual(data.name, "Pilot")
        XCTAssertEqual(data.episode, "S01E01")
        XCTAssertEqual(data.airDate, "December 2, 2013")
    }
}