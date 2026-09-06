import Foundation

struct CharacterDto: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: SummaryLocationDto
    let location: SummaryLocationDto
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
