import Foundation

extension UserDefaults {
    func get<T>(_ key: String, as type: T.Type, default defaultValue: T) -> T {
        object(forKey: key) as? T ?? defaultValue
    }

    func set<T>(_ key: String, value: T) {
        set(value, forKey: key)
    }
}
