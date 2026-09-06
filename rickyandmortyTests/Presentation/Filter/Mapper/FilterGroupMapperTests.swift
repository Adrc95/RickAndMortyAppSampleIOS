import XCTest
@testable import rickyandmorty

final class FilterGroupMapperTests: XCTestCase {

    func `test_given_filter_group_when_mapped_to_display_model_then_maps_title_and_options`() {
        let domain = FilterGroup(
            id: FilterConstants.speciesGroupId,
            options: [
                FilterOption(id: "human"),
                FilterOption(id: "alien"),
                FilterOption(id: "robot")
            ]
        )

        let result = domain.toDisplayModel()

        XCTAssertEqual(result.id, FilterConstants.speciesGroupId)
        XCTAssertEqual(result.options.count, 3)
        XCTAssertEqual(result.options[0], .species(.human))
        XCTAssertEqual(result.options[1], .species(.alien))
        XCTAssertEqual(result.options[2], .species(.robot))
    }

    func `test_given_species_filter_option_when_mapped_to_display_model_then_returns_species_option`() {
        XCTAssertEqual(FilterOption(id: "human").toDisplayModel(), .species(.human))
        XCTAssertEqual(FilterOption(id: "alien").toDisplayModel(), .species(.alien))
        XCTAssertEqual(FilterOption(id: "robot").toDisplayModel(), .species(.robot))
        XCTAssertEqual(FilterOption(id: "animal").toDisplayModel(), .species(.animal))
        XCTAssertEqual(FilterOption(id: "disease").toDisplayModel(), .species(.disease))
        XCTAssertEqual(FilterOption(id: "cronenberg").toDisplayModel(), .species(.cronenberg))
        XCTAssertEqual(FilterOption(id: "poopybutthole").toDisplayModel(), .species(.poopybutthole))
        XCTAssertEqual(FilterOption(id: "mythological").toDisplayModel(), .species(.mythologicalCreature))
    }

    func `test_given_gender_filter_option_when_mapped_to_display_model_then_returns_gender_option`() {
        XCTAssertEqual(FilterOption(id: "female").toDisplayModel(), .gender(.female))
        XCTAssertEqual(FilterOption(id: "male").toDisplayModel(), .gender(.male))
        XCTAssertEqual(FilterOption(id: "genderless").toDisplayModel(), .gender(.genderless))
    }

    func `test_given_status_filter_option_when_mapped_to_display_model_then_returns_status_option`() {
        XCTAssertEqual(FilterOption(id: "alive").toDisplayModel(), .status(.alive))
        XCTAssertEqual(FilterOption(id: "dead").toDisplayModel(), .status(.dead))
    }

    func `test_given_unrecognized_filter_option_when_mapped_to_display_model_then_returns_unknown_species`() {
        XCTAssertEqual(FilterOption(id: "something-random").toDisplayModel(), .species(.unknown))
    }

    func `test_given_unknown_species_display_model_when_mapped_to_filter_value_then_returns_lowercase_unknown`() {
        XCTAssertEqual(FilterOptionDisplayModel.species(.unknown).filterValue, "unknown")
    }

    func `test_given_species_display_model_human_when_mapped_to_filter_value_then_returns_human`() {
        XCTAssertEqual(FilterOptionDisplayModel.species(.human).filterValue, "Human")
        XCTAssertEqual(FilterOptionDisplayModel.species(.mythologicalCreature).filterValue, "Mythological Creature")
    }

    func `test_given_gender_female_display_model_when_mapped_to_filter_value_then_returns_female`() {
        XCTAssertEqual(FilterOptionDisplayModel.gender(.female).filterValue, "Female")
    }

    func `test_given_status_alive_display_model_when_mapped_to_filter_value_then_returns_alive`() {
        XCTAssertEqual(FilterOptionDisplayModel.status(.alive).filterValue, "Alive")
    }
}