import Factory
import Foundation

extension Container {

    var remoteDataSource: Factory<RemoteDataSource> {
        self { RemoteDataSourceImpl() }.singleton
    }

    var settingsPreferenceDataSource: Factory<SettingsPreferenceDataSource> {
        self { SettingsPreferenceDataSourceImpl() }.singleton
    }
}
