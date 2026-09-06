import SwiftUI

struct SettingsScreen: View {

    @State private var viewModel: SettingsViewModel = getViewModel()

    @Environment(\.colorScheme) private var colorScheme

    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("appearance".getString())
                        .font(.interBold(size: 20))
                        .foregroundColor(.themeOnSurface(colorScheme))
                        .padding(.horizontal, 16)
                        .padding(.top, 24)

                    OutlinedCard {
                        VStack(spacing: 8) {
                            ForEach([ThemeModeDisplayModel.light, .dark, .system], id: \.self) { displayModel in
                                ThemeOption(
                                    title: displayModel.text,
                                    icon: displayModel.icon,
                                    isSelected: ThemeModeDisplayModel.from(viewModel.themeMode) == displayModel,
                                    testTag: testTag(for: displayModel)
                                ) {
                                    viewModel.onThemeModeSelected(displayModel.toDomain)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .background(Color.themeBackground(colorScheme))
        .navigationTitle("settings".getString())
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: onBack) {
                    IconView(icon: .backChevron, color: .themeOnSurface(colorScheme), size: 20)
                }
                .accessibilityIdentifier(TestTags.backButton)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color.themeBackground(colorScheme), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            viewModel.loadThemeMode()
        }
    }

    private func testTag(for mode: ThemeModeDisplayModel) -> String {
        switch mode {
        case .light: TestTags.themeLight
        case .dark: TestTags.themeDark
        case .system: TestTags.themeSystem
        }
    }
}
