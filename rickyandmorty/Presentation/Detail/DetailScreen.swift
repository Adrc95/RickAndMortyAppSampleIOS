import Kingfisher
import SwiftUI

struct DetailScreen: View {

    @State private var viewModel: DetailViewModel
    @State private var scrollOffset: CGFloat = 0

    let onBack: () -> Void
    let onSettingsClick: () -> Void

    private let heroHeight: CGFloat = UIScreen.main.bounds.width / CGFloat(PresentationConstants.imageAspectRatio)

    init(characterId: Int, onBack: @escaping () -> Void, onSettingsClick: @escaping () -> Void) {
        self._viewModel = State(wrappedValue: getViewModel(characterId: characterId))
        self.onBack = onBack
        self.onSettingsClick = onSettingsClick
    }

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Group {
            if let character = viewModel.uiState.character {
                DetailContent(character: character)
            } else if viewModel.uiState.isLoading {
                LoadingContent()
            } else if let error = viewModel.uiState.error {
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.themeError(colorScheme))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: onBack) {
                    IconView(icon: .backChevron, color: .themeOnSurface(colorScheme), size: 20)
                }
                .accessibilityIdentifier(TestTags.backButton)
            }
            ToolbarItem(placement: .principal) {
                Text(titleText)
                    .font(.interSemiBold(size: 17))
                    .foregroundColor(.themeOnSurface(colorScheme))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .opacity(titleOpacity)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: onSettingsClick) {
                    IconView(icon: .settings, color: .themeOnSurface(colorScheme), size: 20)
                }
                .accessibilityIdentifier(TestTags.settingsButton)
            }
        }
        .toolbarBackground(Color.themeBackground(colorScheme).opacity(barOpacity), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await viewModel.loadCharacter()
        }
    }

    private var titleText: String {
        guard let character = viewModel.uiState.character else { return "" }
        return scrollOffset <= -heroHeight ? character.name : ""
    }

    private var titleOpacity: Double {
        scrollOffset <= -heroHeight ? 1 : 0
    }

    private var barOpacity: Double {
        Double(max(0, min(1, -scrollOffset / heroHeight)))
    }

    @ViewBuilder
    private func DetailContent(character: CharacterDisplayModel) -> some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .named("detailScroll")).minY
                    )
                }
                .frame(height: 0)

                VStack(spacing: 24) {
                    heroSection(character: character)
                    InfoGrid(character: character)

                    if !character.episodeDetails.isEmpty {
                        EpisodesSection(episodes: character.episodeDetails)
                    }
                }
            }
            .coordinateSpace(name: "detailScroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    scrollOffset = value
                }
            }
        }
    }

    @ViewBuilder
    private func heroSection(character: CharacterDisplayModel) -> some View {
        let screenWidth = UIScreen.main.bounds.width
        let imageSize = screenWidth / CGFloat(PresentationConstants.imageAspectRatio)

        ZStack(alignment: .topLeading) {
            KFImage.url(URL(string: character.image))
                .placeholder { _ in
                    Rectangle()
                        .fill(Color.themeSurfaceContainer(colorScheme))
                }
                .resizable()
                .scaledToFill()
                .frame(width: screenWidth, height: imageSize)
                .clipped()

            LinearGradient(
                colors: [.clear, .clear, Color.themeBackground(colorScheme)],
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(width: screenWidth, height: imageSize)

            StatusBadge(status: character.status)
                .padding(.vertical, 24)
                .padding(.horizontal, 16)

            FavouriteButton(
                isFavourite: character.isFavourite,
                size: 48
            ) {
                Task { await viewModel.onToggleFavourite() }
            }
            .accessibilityIdentifier(TestTags.favouriteButton)
            .frame(width: 48, height: 48)
            .background(Color.themeSurfaceContainerLowest(colorScheme).opacity(0.8))
            .clipShape(Circle())
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .trailing)

            Text(character.name)
                .font(.displayLarge)
                .foregroundColor(.themeOnSurface(colorScheme))
                .lineLimit(2)
                .accessibilityIdentifier(TestTags.characterName)
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .frame(width: screenWidth, height: imageSize)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
