import SwiftUI

struct NavigationRoot: View {

    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeScreen(
                onCharacterClick: { id in
                    path.append(.detail(id))
                },
                onSettingsClick: {
                    path.append(.settings)
                }
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:
                    EmptyView()
                case .detail(let id):
                    DetailScreen(characterId: id) {
                        path.removeLast()
                    } onSettingsClick: {
                        path.append(.settings)
                    }
                case .settings:
                    SettingsScreen {
                        path.removeLast()
                    }
                }
            }
        }
    }
}
