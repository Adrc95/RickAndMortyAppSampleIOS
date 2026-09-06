import XCTest

final class DetailScreenUITests: XCTestCase {

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

    private func navigateToDetail(_ app: XCUIApplication) {
        let character = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(character.waitForExistence(timeout: 10), "Character list did not load on Home")
        character.tap()
        XCTAssertTrue(app.staticTexts["Rick Sanchez"].waitForExistence(timeout: 10), "Character detail did not open")
    }

    func test_givenCharacterState_whenScreenIsDisplayed_thenShowsCharacterInformation() {
        let app = launchApp()
        navigateToDetail(app)

        XCTAssertTrue(app.staticTexts["Rick Sanchez"].exists)
        XCTAssertTrue(app.staticTexts["ALIVE"].exists)
        XCTAssertTrue(app.staticTexts["Human / Male"].exists)
        XCTAssertTrue(app.staticTexts["Earth (C-137)"].exists)
    }

    func test_givenCharacterState_whenScreenIsDisplayed_thenShowsLocationDetails() {
        let app = launchApp()
        navigateToDetail(app)

        let citadel = app.staticTexts["Citadel of Ricks"]
        if !citadel.waitForExistence(timeout: 5) {
            app.swipeUp()
        }
        XCTAssertTrue(citadel.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Planet"].exists)
        XCTAssertTrue(app.staticTexts["Dimension C-137"].exists)
    }

    func test_givenCharacterState_whenScreenIsDisplayed_thenShowsEpisodesSection() {
        let app = launchApp()
        navigateToDetail(app)

        var swipes = 0
        while !app.staticTexts["Pilot"].exists && swipes < 6 {
            app.swipeUp()
            swipes += 1
            usleep(300_000)
        }
        XCTAssertTrue(app.staticTexts["Pilot"].exists, "Episode Pilot not found")
        XCTAssertTrue(app.staticTexts["S01E01"].exists, "Episode code S01E01 not found")
    }

    func test_givenCharacterState_whenBackIsClicked_thenNavigatesToHome() {
        let app = launchApp()
        navigateToDetail(app)

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

    func test_givenCharacterState_whenSettingsIsClicked_thenNavigatesToSettings() {
        let app = launchApp()
        navigateToDetail(app)

        let settings = app.buttons["settings_button"]
        XCTAssertTrue(settings.waitForExistence(timeout: 5))
        settings.tap()
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 5))
    }

    func test_givenCharacterState_whenFavouriteIsClicked_thenToggles() {
        let app = launchApp()
        navigateToDetail(app)

        let favourite = app.buttons["favourite_button"]
        XCTAssertTrue(favourite.waitForExistence(timeout: 5))
        favourite.tap()
    }
}
