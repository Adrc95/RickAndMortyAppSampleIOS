import SwiftUI

struct SearchEmptyView: View {
    let query: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Text("empty_search_results".getString())
            .foregroundColor(.themeOnSurfaceVariant(colorScheme))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}