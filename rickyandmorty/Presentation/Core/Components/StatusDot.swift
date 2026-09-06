import SwiftUI

struct StatusDot: View {
    let status: CharacterStatusDisplayModel

    var body: some View {
        Circle()
            .fill(status.color)
            .frame(width: 8, height: 8)
            .accessibilityLabel(Text(status.text))
    }
}
