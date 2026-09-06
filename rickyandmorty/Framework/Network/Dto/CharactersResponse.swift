import Foundation

struct CharactersResponse: Codable {
    let info: InfoDto
    let results: [CharacterDto]
}
