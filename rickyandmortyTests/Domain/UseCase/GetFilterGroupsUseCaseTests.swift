import XCTest
@testable import rickyandmorty

final class GetFilterGroupsUseCaseTests: XCTestCase {

    private var useCase: GetFilterGroupsUseCase!

    override func setUp() {
        super.setUp()
        useCase = GetFilterGroupsUseCase()
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func `test_when_invoke_then_returns_three_groups`() {
        XCTAssertEqual(useCase.execute().count, 3)
    }

    func `test_when_invoke_then_first_group_is_species`() {
        let result = useCase.execute()
        XCTAssertEqual(result[0].id, FilterConstants.speciesGroupId)
        XCTAssertEqual(
            result[0].options.map { $0.id },
            [
                FilterConstants.speciesHuman,
                FilterConstants.speciesAlien,
                FilterConstants.speciesRobot,
                FilterConstants.speciesAnimal,
                FilterConstants.speciesDisease,
                FilterConstants.speciesCronenberg,
                FilterConstants.speciesPoopybutthole,
                FilterConstants.speciesMythological,
                FilterConstants.unknown
            ]
        )
    }

    func `test_when_invoke_then_second_group_is_gender`() {
        let result = useCase.execute()
        XCTAssertEqual(result[1].id, FilterConstants.genderGroupId)
        XCTAssertEqual(
            result[1].options.map { $0.id },
            [
                FilterConstants.genderFemale,
                FilterConstants.genderMale,
                FilterConstants.genderGenderless,
                FilterConstants.unknown
            ]
        )
    }

    func `test_when_invoke_then_third_group_is_status`() {
        let result = useCase.execute()
        XCTAssertEqual(result[2].id, FilterConstants.statusGroupId)
        XCTAssertEqual(
            result[2].options.map { $0.id },
            [
                FilterConstants.statusAlive,
                FilterConstants.statusDead,
                FilterConstants.unknown
            ]
        )
    }

    func `test_when_invoke_then_species_has_nine_options`() {
        XCTAssertEqual(useCase.execute()[0].options.count, 9)
    }

    func `test_when_invoke_then_gender_has_four_options`() {
        XCTAssertEqual(useCase.execute()[1].options.count, 4)
    }

    func `test_when_invoke_then_status_has_three_options`() {
        XCTAssertEqual(useCase.execute()[2].options.count, 3)
    }
}