import SwiftUI

struct FavouriteButton: View {
    let isFavourite: Bool
    var size: CGFloat = 48
    var onToggle: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: { onToggle?() }) {
            IconView(
                icon: isFavourite ? .favouriteFill : .favourite,
                color: isFavourite ? .themeError(colorScheme) : .themeOnSurfaceVariant(colorScheme),
                size: size * 0.5
            )
        }
        .buttonStyle(.plain)
        .frame(width: size, height: size)
        .background(Color.themeSurfaceContainerLowest(colorScheme).opacity(0.8))
        .clipShape(Circle())
    }
}

#Preview {
    VStack(spacing: 20) {
        FavouriteButton(isFavourite: false)
        FavouriteButton(isFavourite: true)
        FavouriteButton(isFavourite: false, size: 24)
    }
}
