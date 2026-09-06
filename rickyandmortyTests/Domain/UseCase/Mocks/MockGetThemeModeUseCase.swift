import Foundation
@testable import rickyandmorty

final class MockGetThemeModeUseCase: GetThemeModeUseCase {
    var returnedMode: ThemeMode = .system

    override func execute() -> ThemeMode {
        returnedMode
    }
}