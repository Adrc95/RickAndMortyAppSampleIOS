import SwiftUICore

final class Shapes {
    private init() {}

    static let extraSmall = RoundedRectangle(cornerRadius: 4)
    static let small = RoundedRectangle(cornerRadius: 8)
    static let medium = RoundedRectangle(cornerRadius: 12)
    static let large = RoundedRectangle(cornerRadius: 16)
    static let extraLarge = RoundedRectangle(cornerRadius: 24)
}
