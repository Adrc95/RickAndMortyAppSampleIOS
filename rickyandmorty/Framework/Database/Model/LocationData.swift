import Foundation
import SwiftData

@Model
final class LocationData {
    @Attribute(.unique) var id: Int
    var name: String
    var type: String
    var dimension: String
    var residentsCount: Int

    init(id: Int, name: String, type: String, dimension: String, residentsCount: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residentsCount = residentsCount
    }
}
