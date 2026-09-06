import Foundation
@testable import rickyandmorty

final class MockSetThemeModeUseCase: SetThemeModeUseCase {
    private(set) var modes: [ThemeMode] = []

    override func execute(mode: ThemeMode) {
        modes.append(mode)
    }
}