import SwiftUI

enum CharacterStatusDisplayModel {
    case alive
    case dead
    case unknown

    var text: LocalizedStringKey {
        switch self {
        case .alive:
            "alive"
        case .dead:
            "dead"
        case .unknown:
            "unknown"
        }
    }

    var color: Color {
        switch self {
        case .alive:
            .green500
        case .dead:
            .red200
        case .unknown:
            .blueGray600
        }
    }

    static func from(_ value: String) -> CharacterStatusDisplayModel {
        switch value.lowercased() {
        case FilterConstants.statusAlive:
            .alive
        case FilterConstants.statusDead:
            .dead
        default:
            .unknown
        }
    }
}
