import Factory
import XCTest
@testable import rickyandmorty

@MainActor
final class HomeViewModelTests: XCTestCase {

    private var mockGetCharacters: MockGetCharactersUseCase!
    private var mockSearch: MockSearchCharactersUseCase!
    private var mockToggleFavourite: MockToggleFavouriteUseCase!
    private var mockGetFavouriteIds: MockGetFavouriteCharacterIdsUseCase!

    override func setUp() {
        super.setUp()
        let mockGetCharacters = MockGetCharactersUseCase()
        let mockSearch = MockSearchCharactersUseCase()
        let mockToggleFavourite = MockToggleFavouriteUseCase()
        let mockGetFavouriteIds = MockGetFavouriteCharacterIdsUseCase()
        self.mockGetCharacters = mockGetCharacters
        self.mockSearch = mockSearch
        self.mockToggleFavourite = mockToggleFavourite
        self.mockGetFavouriteIds = mockGetFavouriteIds
        Container.shared.getCharactersUseCase.register { mockGetCharacters }
        Container.shared.searchCharactersUseCase.register { mockSearch }
        Container.shared.toggleFavouriteUseCase.register { mockToggleFavourite }
        Container.shared.getFavouriteCharacterIdsUseCase.register { mockGetFavouriteIds }
    }

    override func tearDown() {
        mockGetCharacters = nil
        mockSearch = nil
        mockToggleFavourite = nil
        mockGetFavouriteIds = nil
        Container.shared.reset()
        super.tearDown()
    }

    private func settle(_ nanoseconds: UInt64 = 100_000_000) async {
        try? await Task.sleep(nanoseconds: nanoseconds)
    }

    private func settleDebounce() async {
        try? await Task.sleep(nanoseconds: 800_000_000)
    }

    func `test_given_viewmodel_created_when_observing_ui_state_then_emits_default_state_and_filter_groups`() {
        let viewModel = HomeViewModel()
        XCTAssertEqual(viewModel.uiState.searchQuery, "")
        XCTAssertFalse(viewModel.uiState.filters.hasActiveFilters)
        XCTAssertEqual(viewModel.uiState.filterGroups.count, 3)
        XCTAssertEqual(viewModel.uiState.filterGroups[0].id, FilterConstants.speciesGroupId)
        XCTAssertNil(viewModel.uiState.filters.species)
    }

    func `test_given_empty_query_when_observing_characters_then_loads_all_characters`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("")
        await settleDebounce()
        XCTAssertEqual(mockGetCharacters.executeCalls, 1)
        XCTAssertTrue(mockSearch.calls.isEmpty)
    }

    func `test_given_query_shorter_than_three_characters_when_observing_characters_then_does_not_search`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("ri")
        await settleDebounce()
        XCTAssertEqual(mockGetCharacters.executeCalls, 0)
        XCTAssertTrue(mockSearch.calls.isEmpty)
    }

    func `test_given_query_with_exactly_three_characters_when_observing_characters_then_searches_by_name`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("abc")
        await settleDebounce()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, "abc")
        XCTAssertEqual(mockSearch.lastCall?.species, nil)
        XCTAssertEqual(mockSearch.lastCall?.gender, nil)
        XCTAssertEqual(mockSearch.lastCall?.status, nil)
    }

    func `test_given_query_with_at_least_three_characters_when_observing_characters_then_searches_by_name`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("rick")
        await settleDebounce()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, "rick")
        XCTAssertEqual(mockSearch.lastCall?.species, nil)
        XCTAssertEqual(mockSearch.lastCall?.gender, nil)
        XCTAssertEqual(mockSearch.lastCall?.status, nil)
        XCTAssertEqual(mockGetCharacters.executeCalls, 0)
    }

    func `test_given_filters_selected_when_observing_characters_then_searches_with_domain_filters`() async {
        let viewModel = HomeViewModel()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Human", gender: "Male", status: "Alive"))
        await settle()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, nil)
        XCTAssertEqual(mockSearch.lastCall?.species, "Human")
        XCTAssertEqual(mockSearch.lastCall?.gender, "Male")
        XCTAssertEqual(mockSearch.lastCall?.status, "Alive")
    }

    func `test_given_filters_changed_when_observing_ui_state_then_emits_selected_filters`() async {
        let viewModel = HomeViewModel()
        let filters = CharacterFiltersDisplayModel(species: "Human")
        viewModel.onFiltersChange(filters)
        await settle()
        XCTAssertEqual(viewModel.uiState.filters, filters)
    }

    func `test_given_query_and_filters_selected_when_observing_characters_then_searches_with_both`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("rick")
        await settleDebounce()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Human"))
        await settle()
        XCTAssertEqual(mockSearch.calls.count, 2)
        XCTAssertEqual(mockSearch.lastCall?.name, "rick")
        XCTAssertEqual(mockSearch.lastCall?.species, "Human")
        XCTAssertEqual(mockSearch.lastCall?.gender, nil)
        XCTAssertEqual(mockSearch.lastCall?.status, nil)
    }

    func `test_given_short_query_and_filters_selected_when_observing_characters_then_searches_with_null_name`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("ri")
        await settleDebounce()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(status: "Alive"))
        await settle()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, nil)
        XCTAssertEqual(mockSearch.lastCall?.species, nil)
        XCTAssertEqual(mockSearch.lastCall?.gender, nil)
        XCTAssertEqual(mockSearch.lastCall?.status, "Alive")
    }

    func `test_given_several_queries_during_debounce_when_observing_characters_then_searches_only_with_latest_query`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("ri")
        viewModel.onSearchQueryChange("rick")
        await settleDebounce()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, "rick")
    }

    func `test_given_same_query_emitted_twice_when_observing_characters_then_searches_with_the_query`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("rick")
        await settleDebounce()
        viewModel.onSearchQueryChange("rick")
        await settleDebounce()
        XCTAssertEqual(mockGetCharacters.executeCalls, 0)
        XCTAssertEqual(mockSearch.lastCall?.name, "rick")
        XCTAssertFalse(mockSearch.calls.isEmpty)
    }

    func `test_given_filters_changed_during_debounce_when_observing_characters_then_searches_with_latest_filters`() async {
        let viewModel = HomeViewModel()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Alien"))
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Human"))
        await settle()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.species, "Human")
    }

    func `test_given_filters_selected_when_filters_are_cleared_then_loads_all_characters`() async {
        let viewModel = HomeViewModel()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Human"))
        await settle()
        viewModel.onFiltersChange(CharacterFiltersDisplayModel())
        await settle()
        XCTAssertGreaterThanOrEqual(mockGetCharacters.executeCalls, 1)
    }

    func `test_given_characters_loaded_when_observing_characters_then_maps_them_to_display_models`() async {
        mockGetCharacters.returnedCharacters = [
            makeCharacter { builder in
                builder.withId(1)
                builder.withName("Rick Sanchez")
                builder.withStatus("Dead")
            }
        ]
        let viewModel = HomeViewModel()
        await viewModel.loadInitialData()
        XCTAssertEqual(viewModel.characters.count, 1)
        XCTAssertEqual(viewModel.characters[0].id, 1)
        XCTAssertEqual(viewModel.characters[0].name, "Rick Sanchez")
        XCTAssertEqual(viewModel.characters[0].status, .dead)
    }

    func `test_given_toggle_favourite_called_then_invokes_toggle_favourite_use_case`() async {
        mockGetCharacters.returnedCharacters = [makeCharacter { builder in builder.withId(1) }]
        let viewModel = HomeViewModel()
        await viewModel.loadInitialData()
        await viewModel.onToggleFavourite(characterId: 1)
        XCTAssertEqual(mockToggleFavourite.calls, [1])
    }

    func `test_given_filters_selected_during_query_debounce_when_observing_characters_then_performs_single_search_with_latest_query_and_filters`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("rick")
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(species: "Human"))
        await settleDebounce()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, "rick")
        XCTAssertEqual(mockSearch.lastCall?.species, "Human")
    }

    func `test_given_short_query_and_filters_selected_during_debounce_when_observing_characters_then_searches_by_filters_only`() async {
        let viewModel = HomeViewModel()
        viewModel.onSearchQueryChange("ri")
        viewModel.onFiltersChange(CharacterFiltersDisplayModel(status: "Alive"))
        await settleDebounce()
        XCTAssertEqual(mockSearch.calls.count, 1)
        XCTAssertEqual(mockSearch.lastCall?.name, nil)
        XCTAssertEqual(mockSearch.lastCall?.status, "Alive")
    }
}