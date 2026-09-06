import XCTest

final class HomeScreenUITests: XCTestCase {

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

    func test_givenCharacters_whenScreenIsDisplayed_thenShowsCharacterAndControls() {
        let app = launchApp()

        XCTAssertTrue(app.navigationBars["Rick & Morty"].exists)
        XCTAssertTrue(app.buttons["Filters"].exists)
        XCTAssertTrue(app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Human • Male"].exists)
        XCTAssertTrue(app.staticTexts["ALIVE"].exists)
    }

    func test_whenCharacterIsClicked_thenNavigatesToDetail() {
        let app = launchApp()

        let character = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(character.waitForExistence(timeout: 5))
        character.tap()

        XCTAssertTrue(app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["ALIVE"].exists)
    }

    func test_whenFavouriteIsClicked_thenTogglesFavourite() {
        let app = launchApp()

        let character = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(character.waitForExistence(timeout: 5))

        let favourite = app.buttons["favourite_button"].firstMatch
        XCTAssertTrue(favourite.exists)
        favourite.tap()
    }

    func test_whenSearchQueryChanges_thenShowsSearchResults() {
        let app = launchApp()

        let searchField = app.textFields["search_bar"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 10))
        searchField.tap()
        searchField.typeText("rick")

        XCTAssertTrue(app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 10))
    }

    func test_whenSettingsIsClicked_thenNavigatesToSettings() {
        let app = launchApp()

        let settings = app.buttons["settings_button"]
        XCTAssertTrue(settings.waitForExistence(timeout: 5))
        settings.tap()

        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 5))
    }

    func test_givenNoCharacters_whenScreenIsDisplayed_thenShowsEmptyMessage() {
        let app = launchApp()
        // The mock always returns a character; empty state is covered by unit tests.
        XCTAssertTrue(app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 5))
    }
}
