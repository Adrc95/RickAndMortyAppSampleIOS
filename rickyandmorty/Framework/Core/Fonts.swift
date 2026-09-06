import CoreText
import Foundation
import OSLog

final class FontRegistration {
    private init() {}

    static func registerInterFonts() {
        let fontNames = ["inter_regular", "inter_medium", "inter_semibold", "inter_bold"]
        let bundle = Bundle.main

        for name in fontNames {
            guard let url = bundle.url(forResource: name, withExtension: "ttf") else {
                Logger.app.error("Font not found: \(name).ttf")
                continue
            }
            var error: Unmanaged<CFError>?
            let registered = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
            if !registered {
                Logger.app.error("Font registration failed for \(name): \(String(describing: error?.takeRetainedValue()))")
            }
        }
    }
}
