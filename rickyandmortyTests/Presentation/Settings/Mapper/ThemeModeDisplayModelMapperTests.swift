import XCTest
@testable import rickyandmorty

final class ThemeModeDisplayModelMapperTests: XCTestCase {

    func `test_given_theme_mode_light_when_mapped_to_display_model_then_returns_light`() {
        XCTAssertEqual(ThemeModeDisplayModel.from(.light), .light)
    }

    func `test_given_theme_mode_dark_when_mapped_to_display_model_then_returns_dark`() {
        XCTAssertEqual(ThemeModeDisplayModel.from(.dark), .dark)
    }

    func `test_given_theme_mode_system_when_mapped_to_display_model_then_returns_system`() {
        XCTAssertEqual(ThemeModeDisplayModel.from(.system), .system)
    }

    func `test_given_display_model_light_when_mapped_to_domain_then_returns_light`() {
        XCTAssertEqual(ThemeModeDisplayModel.light.toDomain, .light)
    }

    func `test_given_display_model_dark_when_mapped_to_domain_then_returns_dark`() {
        XCTAssertEqual(ThemeModeDisplayModel.dark.toDomain, .dark)
    }

    func `test_given_display_model_system_when_mapped_to_domain_then_returns_system`() {
        XCTAssertEqual(ThemeModeDisplayModel.system.toDomain, .system)
    }

    func `test_given_raw_value_when_themed_with_theme_mode_from_then_returns_theme_mode`() {
        XCTAssertEqual(ThemeMode.from("light"), .light)
        XCTAssertEqual(ThemeMode.from("dark"), .dark)
        XCTAssertEqual(ThemeMode.from("system"), .system)
        XCTAssertEqual(ThemeMode.from("invalid"), .system)
    }
}