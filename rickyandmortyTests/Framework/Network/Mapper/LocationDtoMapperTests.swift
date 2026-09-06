import XCTest
@testable import rickyandmorty

final class LocationDtoMapperTests: XCTestCase {

    func `test_given_location_dto_when_mapped_to_domain_then_returns_location_detail_with_residents_count`() {
        let dto = makeLocationDto {
            $0.withId(1)
            $0.withName("Earth (C-137)")
            $0.withType("Planet")
            $0.withDimension("Dimension C-137")
            $0.withResidents([
                "https://rickandmortyapi.com/api/character/1",
                "https://rickandmortyapi.com/api/character/2",
                "https://rickandmortyapi.com/api/character/3"
            ])
        }
        let expected = makeLocationDetail {
            $0.withId(1)
            $0.withName("Earth (C-137)")
            $0.withType("Planet")
            $0.withDimension("Dimension C-137")
            $0.withResidentsCount(3)
        }

        XCTAssertEqual(dto.toDomain(), expected)
    }

    func `test_given_location_dto_with_empty_residents_when_mapped_to_domain_then_returns_zero_residents_count`() {
        let dto = makeLocationDto {
            $0.withResidents([])
        }

        XCTAssertEqual(dto.toDomain().residentsCount, 0)
    }

    func `test_given_location_dto_with_many_residents_when_mapped_to_domain_then_returns_correct_count`() {
        let residents = (1...27).map { "https://rickandmortyapi.com/api/character/\($0)" }
        let dto = makeLocationDto {
            $0.withResidents(residents)
        }

        XCTAssertEqual(dto.toDomain().residentsCount, 27)
    }

    func `test_given_location_dto_when_mapped_to_data_then_maps_residents_count`() {
        let data = makeLocationDto().toData()

        XCTAssertEqual(data.id, 1)
        XCTAssertEqual(data.name, "Earth (C-137)")
        XCTAssertEqual(data.type, "Planet")
        XCTAssertEqual(data.dimension, "Dimension C-137")
        XCTAssertEqual(data.residentsCount, 3)
    }
}