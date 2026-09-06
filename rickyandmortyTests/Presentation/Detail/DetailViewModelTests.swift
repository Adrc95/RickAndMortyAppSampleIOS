import Factory
import XCTest
@testable import rickyandmorty

@MainActor
final class DetailViewModelTests: XCTestCase {

    private var mockGetCharacterById: MockGetCharacterByIdUseCase!
    private var mockGetLocation: MockGetLocationByIdUseCase!
    private var mockGetEpisodes: MockGetEpisodesByIdsUseCase!
    private var mockIsFavourite: MockIsCharacterFavouriteUseCase!
    private var mockToggleFavourite: MockToggleFavouriteUseCase!

    override func setUp() {
        super.setUp()
        let mockGetCharacterById = MockGetCharacterByIdUseCase()
        let mockGetLocation = MockGetLocationByIdUseCase()
        let mockGetEpisodes = MockGetEpisodesByIdsUseCase()
        let mockIsFavourite = MockIsCharacterFavouriteUseCase()
        let mockToggleFavourite = MockToggleFavouriteUseCase()
        self.mockGetCharacterById = mockGetCharacterById
        self.mockGetLocation = mockGetLocation
        self.mockGetEpisodes = mockGetEpisodes
        self.mockIsFavourite = mockIsFavourite
        self.mockToggleFavourite = mockToggleFavourite
        Container.shared.getCharacterByIdUseCase.register { mockGetCharacterById }
        Container.shared.getLocationByIdUseCase.register { mockGetLocation }
        Container.shared.getEpisodesByIdsUseCase.register { mockGetEpisodes }
        Container.shared.isCharacterFavouriteUseCase.register { mockIsFavourite }
        Container.shared.toggleFavouriteUseCase.register { mockToggleFavourite }
    }

    override func tearDown() {
        mockGetCharacterById = nil
        mockGetLocation = nil
        mockGetEpisodes = nil
        mockIsFavourite = nil
        mockToggleFavourite = nil
        Container.shared.reset()
        super.tearDown()
    }

    private func makeSuccessfulDetail() -> Character {
        makeCharacter { builder in
            builder.withId(1)
            builder.withName("Rick Sanchez")
            builder.withStatus("Alive")
            builder.withSpecies("Human")
            builder.withOrigin(makeSummaryLocation { $0.withId(1) })
            builder.withLocation(makeSummaryLocation { $0.withId(3) })
            builder.withEpisodeIds([1, 2])
        }
    }

    func `test_given_character_loads_when_observing_ui_state_then_emits_loading_first`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        let viewModel = DetailViewModel(characterId: 1)
        XCTAssertTrue(viewModel.uiState.isLoading)
        await viewModel.loadCharacter()
        XCTAssertFalse(viewModel.uiState.isLoading)
        XCTAssertNotNil(viewModel.uiState.character)
    }

    func `test_given_character_loads_when_observing_ui_state_then_emits_character`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertNotNil(viewModel.uiState.character)
        XCTAssertEqual(viewModel.uiState.character?.id, 1)
        XCTAssertEqual(viewModel.uiState.character?.name, "Rick Sanchez")
        XCTAssertEqual(viewModel.uiState.character?.status, .alive)
        XCTAssertEqual(viewModel.uiState.character?.species, "Human")
        XCTAssertFalse(viewModel.uiState.isLoading)
        XCTAssertNil(viewModel.uiState.error)
    }

    func `test_given_character_with_details_when_loading_then_combines_origin_location_and_episodes`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        mockGetLocation.returnedLocation = makeLocationDetail { $0.withId(1); $0.withName("Earth (C-137)") }
        mockGetEpisodes.returnedEpisodes = [
            makeEpisodeDetail { $0.withId(1); $0.withName("Pilot") },
            makeEpisodeDetail { $0.withId(2); $0.withName("Lawnmower Dog") }
        ]

        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()

        XCTAssertEqual(viewModel.uiState.character?.originDetail?.name, "Earth (C-137)")
        XCTAssertEqual(mockGetLocation.callCount, 2)
        XCTAssertEqual(viewModel.uiState.character?.locationDetail?.name, "Earth (C-137)")
        XCTAssertEqual(viewModel.uiState.character?.episodeDetails.count, 2)
        XCTAssertEqual(viewModel.uiState.character?.episodeDetails[0].name, "Pilot")
        XCTAssertEqual(viewModel.uiState.character?.episodeDetails[1].name, "Lawnmower Dog")
    }

    func `test_given_character_is_favourite_when_loading_then_combines_favourite_state`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        mockIsFavourite.returnedValue = true
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertTrue(viewModel.uiState.character?.isFavourite == true)
    }

    func `test_given_character_detail_fails_when_loading_then_emits_app_error`() async {
        mockGetCharacterById.returnedDetail = nil
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertNil(viewModel.uiState.character)
        XCTAssertFalse(viewModel.uiState.isLoading)
        guard case .connectivity = viewModel.uiState.error else {
            XCTFail("expected connectivity error, got \(String(describing: viewModel.uiState.error))")
            return
        }
    }

    func `test_given_character_detail_fails_with_unknown_error_when_loading_then_maps_to_app_error`() async {
        mockGetCharacterById.error = NSError(domain: "Test", code: -1, userInfo: nil)
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertNil(viewModel.uiState.character)
        guard case .unknown = viewModel.uiState.error else {
            XCTFail("expected unknown error, got \(String(describing: viewModel.uiState.error))")
            return
        }
    }

    func `test_given_location_fails_when_loading_character_then_keeps_character_with_null_details`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        mockGetLocation.error = NetworkError.connectivity
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertNotNil(viewModel.uiState.character)
        XCTAssertNil(viewModel.uiState.character?.originDetail)
        XCTAssertNil(viewModel.uiState.character?.locationDetail)
        XCTAssertNil(viewModel.uiState.error)
    }

    func `test_given_episodes_fail_when_loading_character_then_keeps_character_with_empty_episodes`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        mockGetEpisodes.error = NetworkError.serverError(statusCode: 500)
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        XCTAssertNotNil(viewModel.uiState.character)
        XCTAssertTrue(viewModel.uiState.character?.episodeDetails.isEmpty == true)
        XCTAssertNil(viewModel.uiState.error)
    }

    func `test_given_toggle_favourite_called_then_invokes_toggle_favourite_use_case`() async {
        mockGetCharacterById.returnedDetail = makeSuccessfulDetail()
        let viewModel = DetailViewModel(characterId: 1)
        await viewModel.loadCharacter()
        await viewModel.onToggleFavourite()
        XCTAssertEqual(mockToggleFavourite.calls, [1])
    }
}