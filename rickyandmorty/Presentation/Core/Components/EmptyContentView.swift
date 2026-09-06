import SwiftUI

struct EmptyContentView: View {
    let message: String

    @Environment(\.colorScheme) private var colorScheme

    init(message: String = "empty_characters".getString()) {
        self.message = message
    }

    var body: some View {
        Text(message)
            .foregroundColor(.themeOnSurfaceVariant(colorScheme))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityIdentifier(TestTags.emptyContent)
    }
}

#Preview {
    EmptyContentView()
}
