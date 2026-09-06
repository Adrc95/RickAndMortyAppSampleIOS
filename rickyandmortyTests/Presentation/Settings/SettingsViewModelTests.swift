import Factory
import XCTest
@testable import rickyandmorty

@MainActor
final class SettingsViewModelTests: XCTestCase {

    private var mockGetThemeMode: MockGetThemeModeUseCase!
    private var mockSetThemeMode: MockSetThemeModeUseCase!

    override func setUp() {
        super.setUp()
        let mockGetThemeMode = MockGetThemeModeUseCase()
        let mockSetThemeMode = MockSetThemeModeUseCase()
        self.mockGetThemeMode = mockGetThemeMode
        self.mockSetThemeMode = mockSetThemeMode
        Container.shared.getThemeModeUseCase.register { mockGetThemeMode }
        Container.shared.setThemeModeUseCase.register { mockSetThemeMode }
        Container.shared.appThemeStore.register { AppThemeStore() }
    }

    override func tearDown() {
        mockGetThemeMode = nil
        mockSetThemeMode = nil
        Container.shared.reset()
        super.tearDown()
    }

    func `test_given_theme_mode_is_dark_when_observing_theme_mode_then_emits_dark_mode`() {
        mockGetThemeMode.returnedMode = .dark
        let viewModel = SettingsViewModel()
        viewModel.loadThemeMode()
        XCTAssertEqual(viewModel.themeMode, .dark)
    }

    func `test_given_no_theme_mode_available_when_observing_theme_mode_then_emits_system_mode`() {
        let viewModel = SettingsViewModel()
        viewModel.loadThemeMode()
        XCTAssertEqual(viewModel.themeMode, .system)
    }

    func `test_given_light_theme_mode_when_observing_theme_mode_then_emits_light_mode`() {
        mockGetThemeMode.returnedMode = .light
        let viewModel = SettingsViewModel()
        viewModel.loadThemeMode()
        XCTAssertEqual(viewModel.themeMode, .light)
    }

    func `test_given_dark_selected_when_selecting_theme_then_calls_set_theme_mode_use_case_with_dark_mode`() {
        let viewModel = SettingsViewModel()
        viewModel.onThemeModeSelected(.dark)
        XCTAssertEqual(mockSetThemeMode.modes, [.dark])
    }

    func `test_given_light_selected_when_selecting_theme_then_calls_set_theme_mode_use_case_with_light_mode`() {
        let viewModel = SettingsViewModel()
        viewModel.onThemeModeSelected(.light)
        XCTAssertEqual(mockSetThemeMode.modes, [.light])
    }
}