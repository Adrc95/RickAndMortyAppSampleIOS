import Foundation
import OSLog
import SwiftData

final class SwiftDataLocalDataSource: LocalDataSource {

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            Logger.database.error("SwiftData save failed: \(error.localizedDescription, privacy: .public)")
        }
    }

    func getCharacters() -> [CharacterData] {
        let descriptor = FetchDescriptor<CharacterData>(sortBy: [SortDescriptor(\.id)])
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func getCharacterById(_ id: Int) -> CharacterData? {
        let descriptor = FetchDescriptor<CharacterData>()
        return (try? modelContext.fetch(descriptor))?.first { $0.id == id }
    }

    func insertCharacters(_ characters: [CharacterData]) {
        for character in characters {
            modelContext.insert(character)
        }
        Logger.database.info("Inserted \(characters.count) characters")
        save()
    }

    func clearCharacters() {
        let descriptor = FetchDescriptor<CharacterData>()
        guard let characters = try? modelContext.fetch(descriptor) else { return }
        for character in characters {
            modelContext.delete(character)
        }
        Logger.database.info("Cleared \(characters.count) cached characters")
        save()
    }

    func charactersCount() -> Int {
        let descriptor = FetchDescriptor<CharacterData>()
        return (try? modelContext.fetchCount(descriptor)) ?? 0
    }

    func toggleFavourite(characterId: Int) {
        guard let character = getCharacterById(characterId) else { return }
        character.isFavourite.toggle()
        Logger.database.info("Toggled favourite for character \(characterId)")
        save()
    }

    func isFavourite(characterId: Int) -> Bool {
        getCharacterById(characterId)?.isFavourite ?? false
    }

    func getFavouriteIds() -> [Int] {
        let descriptor = FetchDescriptor<CharacterData>()
        let all = (try? modelContext.fetch(descriptor)) ?? []
        return all.filter { $0.isFavourite }.map { $0.id }
    }

    func getPagingKey(byKey key: String = DataConstants.charactersResource) -> PagingKeyData? {
        let descriptor = FetchDescriptor<PagingKeyData>()
        return (try? modelContext.fetch(descriptor))?.first { $0.key == key }
    }

    func savePagingKey(_ pagingKey: PagingKeyData) {
        if let existing = getPagingKey(byKey: pagingKey.key) {
            existing.currentPage = pagingKey.currentPage
            existing.hasNextPage = pagingKey.hasNextPage
            existing.lastRefreshTimestamp = pagingKey.lastRefreshTimestamp
        } else {
            modelContext.insert(pagingKey)
        }
        Logger.database.debug("Saved paging key for \(pagingKey.key)")
        save()
    }

    func getLocation(id: Int) -> LocationData? {
        let descriptor = FetchDescriptor<LocationData>()
        return (try? modelContext.fetch(descriptor))?.first { $0.id == id }
    }

    func saveLocation(_ location: LocationData) {
        modelContext.insert(location)
        Logger.database.debug("Saved location \(location.id)")
        save()
    }

    func getEpisodes(ids: [Int]) -> [EpisodeData] {
        let descriptor = FetchDescriptor<EpisodeData>()
        let all = (try? modelContext.fetch(descriptor)) ?? []
        return all.filter { ids.contains($0.id) }
    }

    func saveEpisodes(_ episodes: [EpisodeData]) {
        for episode in episodes {
            modelContext.insert(episode)
        }
        Logger.database.debug("Saved \(episodes.count) episodes")
        save()
    }
}
