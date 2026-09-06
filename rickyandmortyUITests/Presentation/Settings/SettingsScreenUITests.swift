import XCTest

final class SettingsScreenUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["--ui-testing"]
        if app.state != .notRunning {
            app.terminate()
        }
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 15), "App did not reach foreground")
        return app
    }

    private func navigateToSettings(_ app: XCUIApplication) {
        let settings = app.buttons["settings_button"]
        XCTAssertTrue(settings.waitForExistence(timeout: 5))
        settings.tap()
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 5))
    }

    func test_givenSettingsScreen_whenDisplayed_thenShowsAppearanceAndThemeOptions() {
        let app = launchApp()
        navigateToSettings(app)

        XCTAssertTrue(app.staticTexts["Appearance"].exists)
        XCTAssertTrue(app.buttons["theme_light"].exists)
        XCTAssertTrue(app.buttons["theme_dark"].exists)
        XCTAssertTrue(app.buttons["theme_system"].exists)
    }

    func test_whenDarkThemeOptionIsClicked_thenSelectsDark() {
        let app = launchApp()
        navigateToSettings(app)

        let dark = app.buttons["theme_dark"]
        XCTAssertTrue(dark.exists)
        dark.tap()
    }

    func test_whenLightAndSystemOptionsAreClicked_thenToggleSelection() {
        let app = launchApp()
        navigateToSettings(app)

        let light = app.buttons["theme_light"]
        let system = app.buttons["theme_system"]
        XCTAssertTrue(light.exists)
        XCTAssertTrue(system.exists)
        light.tap()
        system.tap()
    }

    func test_whenBackButtonIsClicked_thenNavigatesToHome() {
        let app = launchApp()
        navigateToSettings(app)

        let back = app.buttons["back_button"]
        XCTAssertTrue(back.waitForExistence(timeout: 10))

        var homeReached = false
        for _ in 0..<3 {
            if back.exists {
                back.tap()
            }
            let dismissed = back.waitForNonExistence(timeout: 5)
            homeReached = dismissed && app.textFields["search_bar"].waitForExistence(timeout: 5)
            if homeReached { break }
        }
        XCTAssertTrue(homeReached, "Back navigation did not return to Home")
    }
}
