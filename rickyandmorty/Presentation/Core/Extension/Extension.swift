import Foundation
import SwiftUI

extension String {
    func getString() -> String {
        return NSLocalizedString(self, tableName: "Strings", bundle: .main, comment: "")
    }
    func getString(args: CVarArg...) -> String {
        let string = self.getString().replacingOccurrences(of: "$s", with: "$@")
        return String(format: string, args)
    }
}

extension Color {
    init(hex: UInt32) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        let alpha = hex > 0xFFFFFF ? Double((hex >> 24) & 0xFF) / 255 : 1.0

        self.init(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}
