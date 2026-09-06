import Kingfisher
import SwiftUI

struct AsyncCharacterImage: View {
    let imageURL: String
    var clipCircle: Bool = false

    @Environment(\.colorScheme) private var colorScheme
    @State private var failed = false

    var body: some View {
        GeometryReader { geo in
            content
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .clipShape(clipCircle ? AnyShape(Circle()) : AnyShape(RoundedRectangle(cornerRadius: 12)))
        }
        .aspectRatio(CGFloat(PresentationConstants.imageAspectRatio), contentMode: .fit)
    }

    @ViewBuilder
    private var content: some View {
        if failed {
            Image("placeholder_error")
                .resizable()
                .scaledToFit()
        } else {
            KFImage.url(URL(string: imageURL))
                .placeholder { _ in
                    ZStack {
                        LinearGradient(
                            colors: [Color.themeSurfaceContainer(colorScheme), Color.themeSurfaceContainerLowest(colorScheme)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        ProgressView()
                            .scaleEffect(1.5)
                            .foregroundColor(.themeOnSurfaceVariant(colorScheme))
                    }
                }
                .onFailure { _ in
                    failed = true
                }
                .resizable()
                .scaledToFill()
        }
    }
}

#Preview {
    VStack {
        AsyncCharacterImage(imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        AsyncCharacterImage(imageURL: "invalid-url")
    }
}
