import Factory
import Foundation

@Observable
final class HomeViewModel {

    @ObservationIgnored
    @Injected(\.getCharactersUseCase)
    private var getCharactersUseCase
    
    @ObservationIgnored
    @Injected(\.searchCharactersUseCase)
    private var searchCharactersUseCase
    @ObservationIgnored
    
    @Injected(\.toggleFavouriteUseCase)
    private var toggleFavouriteUseCase
    
    @ObservationIgnored
    @Injected(\.getFilterGroupsUseCase)
    private var getFilterGroupsUseCase

    @ObservationIgnored
    @Injected(\.getFavouriteCharacterIdsUseCase)
    private var getFavouriteCharacterIdsUseCase

    var uiState = UIState()
    var characters: [CharacterDisplayModel] = []
    var isLoading = false
    var gridResetToken = 0

    private var currentPage = 1
    private var hasNextPage = true
    private var currentSearchQuery = ""
    private var currentFilters: CharacterFiltersDisplayModel = CharacterFiltersDisplayModel()
    private var reloadTask: Task<Void, Never>?
    private var reloadGeneration: UInt64 = 0
    private var pendingQuery: String?

    var isSearchMode: Bool {
        !currentSearchQuery.isEmpty || currentFilters.hasActiveFilters
    }

    init() {
        uiState.filterGroups = getFilterGroupsUseCase.execute().map { $0.toDisplayModel() }
    }

    func loadInitialData() async {
        currentPage = 1
        hasNextPage = true
        characters = []
        isLoading = true
        uiState.error = nil

        do {
            if isSearchMode {
                let page = try await searchCharactersUseCase.execute(
                    name: currentSearchQuery.isEmpty ? nil : currentSearchQuery,
                    species: currentFilters.species,
                    gender: currentFilters.gender,
                    status: currentFilters.status,
                    page: DataConstants.defaultPage
                )
                characters = page.characters.map { $0.toDisplayModel() }
                hasNextPage = page.hasNext
            } else {
                let results = try await getCharactersUseCase.execute()
                characters = results.map { $0.toDisplayModel() }
                hasNextPage = !results.isEmpty
            }
        } catch is CancellationError {
            return
        } catch {
            guard !Task.isCancelled else { return }
            uiState.error = error.toAppError()
            uiState.isAppendError = false
        }

        isLoading = false
    }

    func refresh() async {
        uiState.isRefreshing = true
        await loadInitialData()
        uiState.isRefreshing = false
    }

    func loadNextPage() async {
        guard !isLoading, hasNextPage else { return }
        isLoading = true
        uiState.isLoadingNextPage = true

        do {
            if isSearchMode {
                let page = try await searchCharactersUseCase.execute(
                    name: currentSearchQuery.isEmpty ? nil : currentSearchQuery,
                    species: currentFilters.species,
                    gender: currentFilters.gender,
                    status: currentFilters.status,
                    page: currentPage + 1
                )
                characters.append(contentsOf: page.characters.map { $0.toDisplayModel() })
                hasNextPage = page.hasNext
            } else {
                let results = try await getCharactersUseCase.executeNextPage()
                characters.append(contentsOf: results.map { $0.toDisplayModel() })
                hasNextPage = !results.isEmpty
            }
            currentPage += 1
        } catch {
            uiState.error = error.toAppError()
            uiState.isAppendError = true
        }

        isLoading = false
        uiState.isLoadingNextPage = false
    }

    func onSearchQueryChange(_ query: String) {
        uiState.searchQuery = query
        pendingQuery = query
        scheduleReload(query: query, debounced: true)
    }

    func onFiltersChange(_ filters: CharacterFiltersDisplayModel) {
        currentFilters = filters
        uiState.filters = filters
        gridResetToken += 1
        if let pendingQuery {
            scheduleReload(query: pendingQuery, debounced: true)
        } else {
            scheduleReload(query: currentSearchQuery, debounced: false)
        }
    }

    private func scheduleReload(query: String, debounced: Bool) {
        reloadTask?.cancel()
        reloadGeneration &+= 1
        let generation = reloadGeneration
        reloadTask = Task { [weak self] in
            if debounced {
                try? await Task.sleep(nanoseconds: UInt64(PresentationConstants.searchDebounceMillis) * 1_000_000)
                guard !Task.isCancelled else { return }
            } else {
                try? await Task.sleep(nanoseconds: 1_000_000)
            }
            guard let self else { return }
            if debounced {
                self.pendingQuery = nil
            }
            await self.commitAndReload(query: query, generation: generation)
        }
    }

    private func commitAndReload(query: String, generation: UInt64) async {
        guard reloadGeneration == generation else { return }
        guard !Task.isCancelled else { return }
        guard query.isEmpty || query.count >= PresentationConstants.minSearchLength || currentFilters.hasActiveFilters else { return }
        let isValidSearchQuery = query.isEmpty || query.count >= PresentationConstants.minSearchLength
        currentSearchQuery = isValidSearchQuery ? query : ""
        if !query.isEmpty && isValidSearchQuery {
            gridResetToken += 1
        }
        await loadInitialData()
    }

    func onToggleFavourite(characterId: Int) async {
        try? await toggleFavouriteUseCase.execute(characterId: characterId)
        if let index = characters.firstIndex(where: { $0.id == characterId }) {
            characters[index].isFavourite.toggle()
        }
    }

    func syncFavouriteStates() async {
        let favouriteIds = await getFavouriteCharacterIdsUseCase.execute()
        let favouriteSet = Set(favouriteIds)
        for index in characters.indices {
            characters[index].isFavourite = favouriteSet.contains(characters[index].id)
        }
    }

    struct UIState {
        var searchQuery: String = ""
        var filters: CharacterFiltersDisplayModel = CharacterFiltersDisplayModel()
        var filterGroups: [FilterGroupDisplayModel] = []
        var error: AppError? = nil
        var isAppendError: Bool = false
        var isRefreshing: Bool = false
        var isLoadingNextPage: Bool = false
    }
}
