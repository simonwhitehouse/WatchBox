//
//  WatchBoxUITests.swift
//  WatchBoxUITests
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import XCTest

class WatchBoxUITests: XCTestCase {

    // End to end test of searching for the film "Inception" and viewing its details.
    // This is potentially slightly flakey so would used mocked data her to clear this up slightly.
    func testFavouritingNewFilm() {
        let app = XCUIApplication()
        app.launch()
        let favouritesNavigationBar = app.navigationBars["Favourites"]
        favouritesNavigationBar.waitForExistence(timeout: 10) // Give extra 10 seconds for application to boot
        favouritesNavigationBar.searchFields["Search and add favourite film"].tap()

        let iKey = app/*@START_MENU_TOKEN@*/.keys["I"]/*[[".keyboards.keys[\"I\"]",".keys[\"I\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()

        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()

        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()

        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()

        let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        pKey.tap()

        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()

        let iKey2 = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey2.tap()

        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()

        nKey.tap()

        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let inceptionSearchResult = app/*@START_MENU_TOKEN@*/.tables["Search results"].staticTexts["Inception"]/*[[".otherElements[\"Double-tap to dismiss\"].tables[\"Search results\"]",".cells.staticTexts[\"Inception\"]",".staticTexts[\"Inception\"]",".tables[\"Search results\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        inceptionSearchResult.waitForExistence(timeout: 60) // 60 seconds time out on API call
        inceptionSearchResult.tap()
    }
}
