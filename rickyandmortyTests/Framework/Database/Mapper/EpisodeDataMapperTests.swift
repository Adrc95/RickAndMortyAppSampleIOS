import XCTest
@testable import rickyandmorty

final class EpisodeDataMapperTests: XCTestCase {

    func `test_given_episode_detail_entity_when_mapped_to_domain_then_returns_episode_detail`() {
        let entity = makeEpisodeData {
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

        XCTAssertEqual(entity.toDomain(), expected)
    }

    func `test_given_episode_detail_entity_with_different_data_when_mapped_to_domain_then_returns_correct_values`() {
        let entity = makeEpisodeData {
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

        XCTAssertEqual(entity.toDomain(), expected)
    }
}