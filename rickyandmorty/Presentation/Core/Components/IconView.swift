import SwiftUI

struct IconView: View {
    let icon: AppIcon
    var color: Color = .primary
    var size: CGFloat?

    var body: some View {
        Group {
            if let size {
                Image(icon.rawValue)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            } else {
                Image(icon.rawValue)
                    .renderingMode(.template)
            }
        }
        .foregroundColor(color)
    }
}
