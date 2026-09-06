import Factory
import SwiftUI
import SwiftData

@main
struct rickyandmortyApp: App {

    @Injected(\.getThemeModeUseCase) private var getThemeModeUseCase

    let modelContainer: ModelContainer

    init() {
        FontRegistration.registerInterFonts()
        let modelContainer = Container.shared.modelContainer()
        self.modelContainer = modelContainer
        AppContainer.configure(modelContext: modelContainer.mainContext)
        Container.shared.appThemeStore().themeMode = getThemeModeUseCase.execute()
    }

    var body: some Scene {
        WindowGroup {
            content
        }
        .modelContainer(modelContainer)
    }

    @ViewBuilder
    private var content: some View {
        AppThemeView()
    }
}

private struct AppThemeView: View {

    @Injected(\.appThemeStore) private var appThemeStore

    var body: some View {
        ContentView()
            .themed(appThemeStore.themeMode)
    }
}
