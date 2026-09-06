import XCTest
@testable import rickyandmorty

final class CharacterDtoMapperTests: XCTestCase {

    func `test_given_character_dto_when_mapped_to_domain_then_returns_character`() {
        let dto = makeCharacterDto {
            $0.withId(1)
            $0.withName("Rick Sanchez")
            $0.withStatus("Alive")
            $0.withSpecies("Human")
            $0.withType("")
            $0.withGender("Male")
            $0.withOrigin(
                makeSummaryLocationDto {
                    $0.withName("Earth (C-137)")
                    $0.withUrl("https://rickandmortyapi.com/api/location/1")
                }
            )
            $0.withLocation(
                makeSummaryLocationDto {
                    $0.withName("Citadel of Ricks")
                    $0.withUrl("https://rickandmortyapi.com/api/location/3")
                }
            )
            $0.withImage("https://rickandmortyapi.com/api/character/avatar/1.jpeg")
            $0.withEpisode([
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ])
            $0.withCreated("2017-11-04T18:48:46.250Z")
        }

        let result = dto.toDomain()

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
        XCTAssertFalse(result.isFavourite)
    }

    func `test_given_character_dto_with_invalid_episode_urls_when_mapped_to_domain_then_returns_empty_ids`() {
        let dto = makeCharacterDto {
            $0.withEpisode(["invalid-url", "https://rickandmortyapi.com/api/episode/abc"])
        }

        let result = dto.toDomain()

        XCTAssertTrue(result.episodeIds.isEmpty)
    }

    func `test_given_character_dto_with_empty_episode_list_when_mapped_to_domain_then_returns_empty_list`() {
        let dto = makeCharacterDto {
            $0.withEpisode([])
        }

        let result = dto.toDomain()

        XCTAssertEqual(result.episodeIds, [])
    }

    func `test_given_character_dto_with_missing_origin_and_location_ids_when_mapped_to_domain_then_returns_minus_one`() {
        let dto = makeCharacterDto {
            $0.withOrigin(
                makeSummaryLocationDto {
                    $0.withUrl("https://example.com/location/no-id")
                }
            )
            $0.withLocation(
                makeSummaryLocationDto {
                    $0.withUrl("")
                }
            )
        }

        let result = dto.toDomain()

        XCTAssertEqual(result.origin.id, -1)
        XCTAssertEqual(result.location.id, -1)
    }

    func `test_given_character_dto_isFavourite_defaults_to_false`() {
        let result = makeCharacterDto().toDomain()

        XCTAssertFalse(result.isFavourite)
    }

    func `test_given_character_dto_when_mapped_to_data_then_maps_ids_and_episode_ids`() {
        let data = makeCharacterDto().toData()

        XCTAssertEqual(data.id, 1)
        XCTAssertEqual(data.name, "Rick Sanchez")
        XCTAssertEqual(data.originId, 1)
        XCTAssertEqual(data.originName, "Earth (C-137)")
        XCTAssertEqual(data.locationId, 3)
        XCTAssertEqual(data.locationName, "Citadel of Ricks")
        XCTAssertEqual(data.episodeIds, [1, 2])
        XCTAssertFalse(data.isFavourite)
    }
}