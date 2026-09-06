import SwiftUI

struct ThemeOption: View {
    let title: String
    let icon: AppIcon
    let isSelected: Bool
    var testTag: String? = nil
    var onSelect: (() -> Void)?

    var body: some View {
        Button(action: { onSelect?() }) {
            HStack(spacing: 16) {
                IconView(icon: icon, color: .secondary, size: 24)

                Text(title)
                    .font(.bodyLarge)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                RadioButton(isSelected: isSelected)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier(testTag ?? "")
    }
}

private struct RadioButton: View {
    let isSelected: Bool

    @Environment(\.colorScheme) private var colorScheme

    private var selectedColor: Color {
        colorScheme == .dark ? .blueGray300 : .black
    }

    private var unselectedColor: Color {
        colorScheme == .dark ? .onSurfaceVariantDark : .onSurfaceVariant
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? selectedColor : unselectedColor, lineWidth: 2)
                .frame(width: 20, height: 20)
            if isSelected {
                Circle()
                    .fill(selectedColor)
                    .frame(width: 12, height: 12)
            }
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        ThemeOption(title: "Light Mode", icon: .lightMode, isSelected: false)
        ThemeOption(title: "Dark Mode", icon: .darkMode, isSelected: true)
        ThemeOption(title: "System Default", icon: .systemMode, isSelected: false)
    }
    .padding()
}
