import SwiftUI

struct CharacterCardSkeleton: View {
    @State private var isAnimating = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.themeSurfaceContainer(colorScheme))
                .frame(width: 100, height: 100)
                .padding(.top, 12)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(spacing: 6) {
                HStack {
                    Circle()
                        .fill(Color.themeSurfaceContainer(colorScheme))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color.themeSurfaceContainer(colorScheme))
                        .frame(height: 10)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                HStack {
                    Rectangle()
                        .fill(Color.themeSurfaceContainer(colorScheme))
                        .frame(height: 8)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .background(Color.themeSurfaceContainerLowest(colorScheme))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .opacity(isAnimating ? 0.5 : 1.0)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
