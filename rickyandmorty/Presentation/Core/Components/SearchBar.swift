import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = ""
    var onCommit: (() -> Void)?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeholder, text: $text)
                .accessibilityIdentifier(TestTags.searchBar)
                .textFieldStyle(.plain)
                .foregroundColor(.themeOnSurface(colorScheme))
                .onSubmit { onCommit?() }
                .padding(.vertical, 10)
                .padding(.leading, 40)
                .padding(.trailing, 10)
                .background(Color.themeSurfaceContainerLowest(colorScheme))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.themeOutlineVariant(colorScheme), lineWidth: 1)
                )
                .overlay(
                    HStack {
                        IconView(icon: .search, color: .themeOnSurfaceVariant(colorScheme))
                            .padding(.leading, 10)
                        Spacer()
                        if !text.isEmpty {
                            Button(action: { text = "" }) {
                                IconView(icon: .close, color: .themeOnSurfaceVariant(colorScheme))
                            }
                            .padding(.trailing, 10)
                        }
                    }
                )
        }
    }
}

#Preview {
    SearchBar(text: .constant("Rick"))
}
