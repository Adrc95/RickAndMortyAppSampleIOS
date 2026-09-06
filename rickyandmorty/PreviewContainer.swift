import Factory
import Foundation
import SwiftData
import SwiftUI

@MainActor
final class PreviewContainer {
    private init() {}

    static func configure() -> ModelContainer {
        let container = try! DataStore.makeContainer(inMemory: true)
        Container.shared.modelContainer.register { container }
        AppContainer.configure(modelContext: container.mainContext)
        return container
    }
}

extension View {
    func withPreviewContainer() -> some View {
        let container = PreviewContainer.configure()
        return self.modelContainer(container)
    }
}