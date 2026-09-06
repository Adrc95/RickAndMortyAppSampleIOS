import XCTest
@testable import rickyandmorty

final class LocationDataMapperTests: XCTestCase {

    func `test_given_location_detail_entity_when_mapped_to_domain_then_returns_location_detail`() {
        let entity = makeLocationData {
            $0.withId(1)
            $0.withName("Earth (C-137)")
            $0.withType("Planet")
            $0.withDimension("Dimension C-137")
            $0.withResidentsCount(27)
        }
        let expected = makeLocationDetail {
            $0.withId(1)
            $0.withName("Earth (C-137)")
            $0.withType("Planet")
            $0.withDimension("Dimension C-137")
            $0.withResidentsCount(27)
        }

        XCTAssertEqual(entity.toDomain(), expected)
    }

    func `test_given_location_detail_entity_with_zero_residents_when_mapped_to_domain_then_returns_zero`() {
        let entity = makeLocationData {
            $0.withResidentsCount(0)
        }

        XCTAssertEqual(entity.toDomain().residentsCount, 0)
    }
}