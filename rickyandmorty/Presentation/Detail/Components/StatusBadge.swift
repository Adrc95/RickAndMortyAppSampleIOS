import SwiftUI

struct StatusBadge: View {
    let status: CharacterStatusDisplayModel

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(status.color)
                .frame(width: 8, height: 8)
            Text(status.text)
                .font(.bodyMedium)
                .textCase(.uppercase)
                .foregroundColor(.themeOnSurface(colorScheme))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.themeSurfaceContainerLowest(colorScheme).opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.themeOutlineVariant(colorScheme), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(TestTags.statusBadge)
    }
}
