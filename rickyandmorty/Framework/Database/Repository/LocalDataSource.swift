import Foundation

protocol LocalDataSource {
    func getCharacters() -> [CharacterData]
    func getCharacterById(_ id: Int) -> CharacterData?
    func insertCharacters(_ characters: [CharacterData])
    func clearCharacters()
    func charactersCount() -> Int
    func toggleFavourite(characterId: Int)
    func isFavourite(characterId: Int) -> Bool
    func getFavouriteIds() -> [Int]

    func getPagingKey(byKey key: String) -> PagingKeyData?
    func savePagingKey(_ pagingKey: PagingKeyData)

    func getLocation(id: Int) -> LocationData?
    func saveLocation(_ location: LocationData)

    func getEpisodes(ids: [Int]) -> [EpisodeData]
    func saveEpisodes(_ episodes: [EpisodeData])
}