import SwiftData

final class DataStore {
    private init() {}

    static let schema = Schema([
        CharacterData.self,
        PagingKeyData.self,
        LocationData.self,
        EpisodeData.self
    ])

    static func makeContainer(inMemory: Bool = false) throws -> ModelContainer {
        try ModelContainer(for: schema, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
    }
}
