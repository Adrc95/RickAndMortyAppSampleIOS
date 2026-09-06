import Factory
import Foundation
import SwiftData

final class ModelContextBox: @unchecked Sendable {
    let modelContext: ModelContext
    init(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension Container {

    var modelContainer: Factory<ModelContainer> {
        self { try! DataStore.makeContainer() }.singleton
    }

    var modelContextBox: Factory<ModelContextBox> {
        self { fatalError("ModelContext must be registered in AppContainer.configure") }.singleton
    }

    var localDataSource: Factory<LocalDataSource> {
        self { SwiftDataLocalDataSource(modelContext: self.modelContextBox().modelContext) }.singleton
    }
}
