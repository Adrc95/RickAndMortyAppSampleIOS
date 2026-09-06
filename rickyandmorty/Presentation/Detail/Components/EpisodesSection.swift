import SwiftUI

struct EpisodesSection: View {
    let episodes: [EpisodeDetail]

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        if !episodes.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                Text("appears_in".getString())
                    .font(.headlineSmall)
                    .foregroundColor(.themeOnSurface(colorScheme))
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        ForEach(episodes) { episode in
                            EpisodeCard(episode: episode)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
            .accessibilityIdentifier(TestTags.episodesSection)
        }
    }
}

private struct EpisodeCard: View {
    let episode: EpisodeDetail

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(episode.episode)
                .font(.labelMedium)
                .foregroundColor(.themeOnSurfaceVariant(colorScheme))

            Spacer(minLength: 4)

            Text(episode.name)
                .font(.headlineSmall)
                .foregroundColor(.themeOnSurface(colorScheme))
                .lineLimit(2)
        }
        .padding(20)
        .frame(width: 240)
        .background(Color.themeSurfaceContainerLowest(colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.themeOutlineVariant(colorScheme), lineWidth: 1)
        )
    }
}
