import Factory
import Foundation

final class CharacterRepositoryImpl: CharacterRepository {

    @Injected(\.remoteDataSource) private var remoteDataSource
    @Injected(\.localDataSource) private var localDataSource

    func getCharacters() async throws -> [Character] {
        let pagingKey: PagingKeyData? = await MainActor.run { localDataSource.getPagingKey(byKey: DataConstants.charactersResource) }
        let isCacheFresh = pagingKey?.isCacheFresh ?? false
        let hasCachedCharacters: Bool = await MainActor.run { localDataSource.charactersCount() > 0 }

        if isCacheFresh && hasCachedCharacters {
            return await MainActor.run { localDataSource.getCharacters().map { $0.toDomain() } }
        }

        let firstResponse = try await remoteDataSource.getCharacters(page: DataConstants.defaultPage)
        var currentPage = DataConstants.defaultPage
        var hasNextPage = firstResponse.info.next != nil

        await MainActor.run {
            insertEntitiesPreservingFavourites(firstResponse.results.map { $0.toData() }, deleteOld: true)
        }

        for page in (DataConstants.defaultPage + 1)...DataConstants.initialLoadPages {
            guard hasNextPage else { break }
            guard let nextResponse = try? await remoteDataSource.getCharacters(page: page) else { break }
            await MainActor.run {
                insertEntitiesPreservingFavourites(nextResponse.results.map { $0.toData() }, deleteOld: false)
            }
            currentPage = page
            hasNextPage = nextResponse.info.next != nil
        }

        let currentPageSnapshot = currentPage
        let hasNextPageSnapshot = hasNextPage
        await MainActor.run {
            localDataSource.savePagingKey(PagingKeyData(
                currentPage: currentPageSnapshot,
                hasNextPage: hasNextPageSnapshot
            ))
        }

        return await MainActor.run { localDataSource.getCharacters().map { $0.toDomain() } }
    }

    func loadNextPage() async throws -> [Character] {
        let pagingKey: PagingKeyData? = await MainActor.run { localDataSource.getPagingKey(byKey: DataConstants.charactersResource) }
        guard pagingKey?.hasNextPage == true else { return [] }
        let nextPage = (pagingKey?.currentPage ?? 0) + 1

        let response = try await remoteDataSource.getCharacters(page: nextPage)
        let apiEntities = response.results.map { $0.toData() }

        await MainActor.run {
            insertEntitiesPreservingFavourites(apiEntities, deleteOld: false)
            localDataSource.savePagingKey(PagingKeyData(
                currentPage: nextPage,
                hasNextPage: response.info.next != nil
            ))
        }

        return await MainActor.run {
            let ids = apiEntities.map { $0.id }
            return ids.compactMap { id in
                localDataSource.getCharacterById(id)?.toDomain()
            }
        }
    }

    func searchCharacters(name: String?, species: String?, gender: String?, status: String?, page: Int) async throws -> CharacterPage {
        do {
            let response = try await remoteDataSource.searchCharacters(page: page, name: name, species: species, gender: gender, status: status)
            return CharacterPage(
                characters: response.results.map { $0.toDomain() },
                hasNext: response.info.next != nil
            )
        } catch {
            if let appError = error as? AppError,
               case .server(let code) = appError,
               code == 404 {
                return CharacterPage(characters: [], hasNext: false)
            }
            throw error
        }
    }

    func getCharacterDetail(id: Int) async throws -> Character {
        let cached: CharacterData? = await MainActor.run { localDataSource.getCharacterById(id) }
        if let cached {
            return cached.toDomain()
        }

        let dto = try await remoteDataSource.getCharacterDetail(id: id)
        let entity = dto.toData()
        await MainActor.run { localDataSource.insertCharacters([entity]) }
        return entity.toDomain()
    }

    func getCachedCharacter(id: Int) async -> Character? {
        await MainActor.run { localDataSource.getCharacterById(id)?.toDomain() }
    }

    func refreshCharacter(id: Int) async -> Character? {
        guard let dto = try? await remoteDataSource.getCharacterDetail(id: id) else { return nil }
        let entity = dto.toData()
        await MainActor.run {
            if let existing = localDataSource.getCharacterById(id) {
                entity.isFavourite = existing.isFavourite
            }
            localDataSource.insertCharacters([entity])
        }
        return entity.toDomain()
    }

    func isFavourite(characterId: Int) async -> Bool {
        await MainActor.run { localDataSource.isFavourite(characterId: characterId) }
    }

    func toggleFavourite(characterId: Int) async throws {
        await MainActor.run { localDataSource.toggleFavourite(characterId: characterId) }
    }

    func getFavouriteIds() async -> [Int] {
        await MainActor.run { localDataSource.getFavouriteIds() }
    }

    @MainActor
    private func insertEntitiesPreservingFavourites(_ entities: [CharacterData], deleteOld: Bool) {
        let favouriteSet = Set(localDataSource.getFavouriteIds())

        if deleteOld {
            localDataSource.clearCharacters()
        }

        for entity in entities {
            if favouriteSet.contains(entity.id) {
                entity.isFavourite = true
            }
        }
        localDataSource.insertCharacters(entities)
    }
}
