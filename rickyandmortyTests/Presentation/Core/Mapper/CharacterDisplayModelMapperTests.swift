import XCTest
@testable import rickyandmorty

final class CharacterDisplayModelMapperTests: XCTestCase {

    func `test_given_character_when_mapped_to_display_model_then_returns_character_display_model`() {
        let domain = makeCharacter {
            $0.withId(1)
            $0.withName("Rick Sanchez")
            $0.withStatus("Alive")
            $0.withSpecies("Human")
            $0.withType("")
            $0.withGender("Male")
            $0.withOrigin(
                makeSummaryLocation {
                    $0.withId(1)
                    $0.withName("Earth (C-137)")
                }
            )
            $0.withLocation(
                makeSummaryLocation {
                    $0.withId(3)
                    $0.withName("Citadel of Ricks")
                }
            )
            $0.withImage("https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            $0.withEpisodeIds([1, 2])
            $0.withCreated("2017-11-04T18:48:46.250Z")
            $0.withIsFavourite(true)
        }

        let result = domain.toDisplayModel()

        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Rick Sanchez")
        XCTAssertEqual(result.status, .alive)
        XCTAssertEqual(result.species, "Human")
        XCTAssertEqual(result.type, "")
        XCTAssertEqual(result.gender, "Male")
        XCTAssertEqual(result.origin.name, "Earth (C-137)")
        XCTAssertEqual(result.location.name, "Citadel of Ricks")
        XCTAssertEqual(result.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        XCTAssertEqual(result.episodeIds, [1, 2])
        XCTAssertTrue(result.isFavourite)
    }

    func `test_given_character_when_mapped_to_display_model_without_details_then_details_are_nil`() {
        let domain = makeCharacter { $0.withId(1) }

        let result = domain.toDisplayModel()

        XCTAssertNil(result.originDetail)
        XCTAssertNil(result.locationDetail)
        XCTAssertTrue(result.episodeDetails.isEmpty)
    }

    func `test_given_character_status_alive_when_mapped_to_display_model_then_returns_alive_status`() {
        let domain = makeCharacter { $0.withStatus("Alive") }

        XCTAssertEqual(domain.toDisplayModel().status, .alive)
    }

    func `test_given_character_status_dead_when_mapped_to_display_model_then_returns_dead_status`() {
        let domain = makeCharacter { $0.withStatus("Dead") }

        XCTAssertEqual(domain.toDisplayModel().status, .dead)
    }

    func `test_given_character_status_unknown_when_mapped_to_display_model_then_returns_unknown_status`() {
        let domain = makeCharacter { $0.withStatus("unknown") }

        XCTAssertEqual(domain.toDisplayModel().status, .unknown)
    }
}