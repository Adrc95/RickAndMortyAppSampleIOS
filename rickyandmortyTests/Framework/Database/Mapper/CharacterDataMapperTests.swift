import XCTest
@testable import rickyandmorty

final class CharacterDataMapperTests: XCTestCase {

    func `test_given_character_entity_when_mapped_to_domain_then_returns_character`() {
        let entity = makeCharacterData {
            $0.withId(1)
            $0.withName("Rick Sanchez")
            $0.withStatus("Alive")
            $0.withSpecies("Human")
            $0.withType("")
            $0.withGender("Male")
            $0.withOriginName("Earth (C-137)")
            $0.withOriginId(1)
            $0.withLocationName("Citadel of Ricks")
            $0.withLocationId(3)
            $0.withImage("https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            $0.withEpisodeIds([1, 2])
            $0.withCreated("2017-11-04T18:48:46.250Z")
            $0.withIsFavourite(true)
        }

        let result = entity.toDomain()

        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Rick Sanchez")
        XCTAssertEqual(result.status, "Alive")
        XCTAssertEqual(result.species, "Human")
        XCTAssertEqual(result.type, "")
        XCTAssertEqual(result.gender, "Male")
        XCTAssertEqual(result.origin, SummaryLocation(id: 1, name: "Earth (C-137)"))
        XCTAssertEqual(result.location, SummaryLocation(id: 3, name: "Citadel of Ricks"))
        XCTAssertEqual(result.image, "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        XCTAssertEqual(result.episodeIds, [1, 2])
        XCTAssertEqual(result.created, "2017-11-04T18:48:46.250Z")
        XCTAssertTrue(result.isFavourite)
    }

    func `test_given_character_entity_with_null_origin_id_when_mapped_to_domain_then_returns_minus_one`() {
        let entity = makeCharacterData {
            $0.withOriginId(nil)
        }

        XCTAssertEqual(entity.toDomain().origin.id, -1)
    }

    func `test_given_character_entity_with_null_location_id_when_mapped_to_domain_then_returns_minus_one`() {
        let entity = makeCharacterData {
            $0.withLocationId(nil)
        }

        XCTAssertEqual(entity.toDomain().location.id, -1)
    }

    func `test_given_character_entity_with_favourite_true_when_mapped_to_domain_then_preserves_favourite`() {
        let entity = makeCharacterData {
            $0.withIsFavourite(true)
        }

        XCTAssertTrue(entity.toDomain().isFavourite)
    }
}