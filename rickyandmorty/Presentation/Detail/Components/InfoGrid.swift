import SwiftUI

struct InfoGrid: View {
    let character: CharacterDisplayModel
    @Environment(\.colorScheme) private var colorScheme

    private var labelColor: Color {
        colorScheme == .dark ? .onSurfaceVariantDark : .onSurfaceVariant
    }

    var body: some View {
        VStack(spacing: 12) {
            InfoCard(
                icon: .gender,
                label: "specie_gender".getString(),
                value: "\(character.species) / \(character.gender)",
                labelColor: labelColor
            )

            InfoCard(
                icon: .world,
                label: "origin".getString(),
                value: character.origin.name,
                moreInfo: true,
                type: character.originDetail?.type,
                dimension: character.originDetail?.dimension,
                residentsCount: character.originDetail?.residentsCount,
                labelColor: labelColor
            )

            InfoCard(
                icon: .location,
                label: "last_seen".getString(),
                value: character.location.name,
                moreInfo: true,
                type: character.locationDetail?.type,
                dimension: character.locationDetail?.dimension,
                residentsCount: character.locationDetail?.residentsCount,
                labelColor: labelColor
            )
        }
        .padding(.horizontal, 16)
        .accessibilityIdentifier(TestTags.infoGrid)
    }
}

private struct InfoCard: View {
    let icon: AppIcon
    let label: String
    let value: String
    var moreInfo: Bool = false
    var type: String? = nil
    var dimension: String? = nil
    var residentsCount: Int? = nil
    var labelColor: Color = .secondary

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        OutlinedCard {
            VStack(alignment: .leading, spacing: 4) {
                IconView(icon: icon, color: .themeOnSurface(colorScheme))
                    .font(.headlineSmall)

                Text(label.uppercased())
                    .font(.labelMedium)
                    .tracking(0.5)
                    .foregroundColor(labelColor)

                Text(value)
                    .font(.headlineSmall)
                    .foregroundColor(.themeOnSurface(colorScheme))
                    .lineLimit(2)

                if moreInfo {
                    Divider()
                        .overlay(Color.themeOutlineVariant(colorScheme))

                    MoreInfo(type: type, dimension: dimension, residentsCount: residentsCount)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct MoreInfo: View {
    let type: String?
    let dimension: String?
    let residentsCount: Int?

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MoreInfoItem(option: "type".getString(), text: type ?? PresentationConstants.fallbackText)
            MoreInfoItem(option: "dimensions".getString(), text: dimension ?? PresentationConstants.fallbackText)
            MoreInfoBadge(option: "residents".getString(), text: residentsCount?.toString() ?? PresentationConstants.fallbackText, colorScheme: colorScheme)
        }
    }
}

private struct MoreInfoItem: View {
    let option: String
    let text: String

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack {
            Text(option.uppercased())
                .font(.bodyLarge)
                .foregroundColor(.themeOnSurfaceVariant(colorScheme))
            Spacer()
            Text(text)
                .font(.bodyLarge)
                .foregroundColor(.themeOnSurface(colorScheme))
        }
    }
}

private struct MoreInfoBadge: View {
    let option: String
    let text: String
    var colorScheme: ColorScheme

    var body: some View {
        HStack {
            Text(option.uppercased())
                .font(.bodyLarge)
                .foregroundColor(.themeOnSurfaceVariant(colorScheme))
            Spacer()
            Text(text)
                .font(.bodyLarge)
                .foregroundColor(.themeOnSurface(colorScheme))
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .background(Color.themePrimary(colorScheme).opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.themePrimary(colorScheme).opacity(0.2), lineWidth: 1)
                )
        }
    }
}

private extension Int {
    func toString() -> String {
        String(self)
    }
}
