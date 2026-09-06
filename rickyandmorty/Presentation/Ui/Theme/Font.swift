import SwiftUI

extension Font {

    static func interRegular(size: CGFloat) -> Font {
        .custom("Inter18pt-Regular", size: size)
    }

    static func interMedium(size: CGFloat) -> Font {
        .custom("Inter18pt-Medium", size: size)
    }

    static func interSemiBold(size: CGFloat) -> Font {
        .custom("Inter18pt-SemiBold", size: size)
    }

    static func interBold(size: CGFloat) -> Font {
        .custom("Inter18pt-Bold", size: size)
    }

    static var displayLarge: Font {
        .interBold(size: 32)
    }

    static var displayMedium: Font {
        .interSemiBold(size: 24)
    }

    static var headlineSmall: Font {
        .interSemiBold(size: 20)
    }

    static var bodyLarge: Font {
        .interRegular(size: 16)
    }

    static var bodyMedium: Font {
        .interRegular(size: 14)
    }

    static var labelMedium: Font {
        .interMedium(size: 12)
    }

    static var labelSmall: Font {
        .interSemiBold(size: 11)
    }
}
