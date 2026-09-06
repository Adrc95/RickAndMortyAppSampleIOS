import Factory
import Foundation

extension Container {

    var userDefaults: Factory<UserDefaults> {
        self { UserDefaults.standard }.singleton
    }

    var appThemeStore: Factory<AppThemeStore> {
        self { AppThemeStore() }.singleton
    }
}
