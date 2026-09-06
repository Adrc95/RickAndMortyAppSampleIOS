import SwiftUI

struct CharacterCard: View {
    let character: CharacterDisplayModel
    var showFavourite: Bool = true
    var onTap: (() -> Void)?
    var onFavouriteToggle: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: { onTap?() }) {
            VStack(spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    AsyncCharacterImage(imageURL: character.image)

                    if showFavourite {
                        FavouriteButton(isFavourite: character.isFavourite, size: 48) {
                            onFavouriteToggle?()
                        }
                        .accessibilityIdentifier(TestTags.favouriteButton)
                        .padding(16)
                    }
                }

                VStack(spacing: 4) {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(character.status.color)
                            .frame(width: 8, height: 8)
                        Text(character.status.text)
                            .font(.labelSmall)
                            .textCase(.uppercase)
                            .foregroundColor(.themeOnSurfaceVariant(colorScheme))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text(character.name)
                        .font(.interSemiBold(size: 16))
                        .lineLimit(1)
                        .foregroundColor(.themeOnSurface(colorScheme))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("\(character.species) • \(character.gender)")
                        .font(.labelMedium)
                        .foregroundColor(.themeOnSurfaceVariant(colorScheme))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
        }
        .buttonStyle(.plain)
        .background(Color.themeSurfaceContainerLowest(colorScheme))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.themeOutlineVariant(colorScheme), lineWidth: 1)
        )
    }
}
