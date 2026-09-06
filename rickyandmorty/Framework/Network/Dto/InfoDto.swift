import Foundation

struct InfoDto: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
