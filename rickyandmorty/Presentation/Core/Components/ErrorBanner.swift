import SwiftUI

struct ErrorBanner: View {
    let message: String
    var onRetry: (() -> Void)? = nil

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 4) {
            Text(message)
                .font(.bodyMedium)
                .foregroundColor(.themeOnErrorContainer(colorScheme))
                .multilineTextAlignment(.center)

            if let onRetry {
                Button(action: onRetry) {
                    Text("retry".getString())
                        .font(.bodyMedium)
                        .foregroundColor(.themePrimary(colorScheme))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.themeSurfaceContainerLowest(colorScheme).opacity(0.8))
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    ErrorBanner(message: "No internet connection") {}
}
