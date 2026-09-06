import SwiftUI

struct OutlinedCard<Content: View>: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        content()
            .background(Color.themeSurfaceContainerLowest(colorScheme))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.themeOutlineVariant(colorScheme), lineWidth: 1)
            )
    }
}

#Preview {
    OutlinedCard {
        Text("Card Content")
            .frame(maxWidth: .infinity)
    }
    .padding()
}
