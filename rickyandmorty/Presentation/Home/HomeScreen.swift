import SwiftUI

struct HomeScreen: View {

    @State private var viewModel: HomeViewModel = getViewModel()
    @State private var showFilters = false

    @Environment(\.colorScheme) private var colorScheme

    let onCharacterClick: (Int) -> Void
    let onSettingsClick: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                SearchBar(text: $viewModel.uiState.searchQuery, placeholder: "search_by_name_placeholder".getString())

                if !viewModel.uiState.filterGroups.isEmpty {
                    let hasActiveFilters = viewModel.uiState.filters.hasActiveFilters
                    Button(action: { showFilters = true }) {
                        HStack(spacing: 4) {
                            IconView(icon: .filter)
                            Text("filters".getString())
                                .font(.bodyMedium)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundColor(hasActiveFilters ? Color.navy950 : Color.themeOnSurface(colorScheme))
                        .background(hasActiveFilters ? Color.cyan300 : Color.clear)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(hasActiveFilters ? Color.cyan300 : Color.themeOutlineVariant(colorScheme), lineWidth: 1)
                        )
                    }
                    .accessibilityIdentifier(TestTags.filterButton)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            CharacterGrid(
                characters: viewModel.characters,
                isLoadingNextPage: viewModel.uiState.isLoadingNextPage,
                showFavourite: !viewModel.isSearchMode,
                scrollResetToken: viewModel.gridResetToken,
                onCharacterTap: onCharacterClick,
                onFavouriteToggle: { id in
                    Task { await viewModel.onToggleFavourite(characterId: id) }
                },
                onScrollToBottom: {
                    Task { await viewModel.loadNextPage() }
                }
            )
        }
        .refreshable {
            await viewModel.refresh()
        }
        .navigationTitle("app_name".getString())
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onSettingsClick) {
                    IconView(icon: .settings, color: .themeOnSurface(colorScheme), size: 20)
                }
                .accessibilityIdentifier(TestTags.settingsButton)
            }
        }
        .toolbarBackground(Color.themeBackground(colorScheme), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .overlay(alignment: .bottom) {
            if let error = viewModel.uiState.error {
                ErrorBanner(
                    message: viewModel.uiState.isAppendError
                        ? "error_load_characters".getString()
                        : error.errorDescription ?? "error_connectivity".getString(),
                    onRetry: {
                        if viewModel.uiState.isAppendError {
                            Task { await viewModel.loadNextPage() }
                        } else {
                            Task { await viewModel.loadInitialData() }
                        }
                    }
                )
            }
        }
        .overlay {
            if viewModel.isLoading && viewModel.characters.isEmpty {
                LoadingContent()
            } else if !viewModel.isLoading && viewModel.characters.isEmpty {
                if viewModel.isSearchMode {
                    SearchEmptyView(query: viewModel.uiState.searchQuery)
                } else {
                    EmptyContentView()
                }
            }
        }
        .sheet(isPresented: $showFilters) {
            FilterBottomSheet(
                filterGroups: viewModel.uiState.filterGroups,
                currentFilters: viewModel.uiState.filters,
                onApply: { filters in
                    viewModel.onFiltersChange(filters)
                    showFilters = false
                },
                onClear: {
                    viewModel.onFiltersChange(CharacterFiltersDisplayModel())
                    showFilters = false
                }
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .onChange(of: viewModel.uiState.searchQuery) { oldValue, newValue in
            viewModel.onSearchQueryChange(newValue)
        }
        .task {
            await viewModel.loadInitialData()
        }
        .onAppear {
            Task { await viewModel.syncFavouriteStates() }
        }
    }
}
