import Factory
import Foundation
import SwiftData

final class AppContainer {

    static func configure(modelContext: ModelContext) {
        let context = ModelContextBox(modelContext)
        Container.shared.modelContextBox.register { context }

        _ = Container.shared.localDataSource()
        _ = Container.shared.remoteDataSource()
        _ = Container.shared.imageCache()
        _ = Container.shared.characterRepository()
        _ = Container.shared.locationRepository()
        _ = Container.shared.episodeRepository()
        _ = Container.shared.settingsRepository()
    }
}
