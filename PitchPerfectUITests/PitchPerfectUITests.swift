//
//  PitchPerfectUITests.swift
//  PitchPerfectUITests
//
//  Created by AKSHAY SUNDERWANI on 21/04/17.
//  Copyright © 2017 AKSHAY SUNDERWANI. All rights reserved.
//

import XCTest

class PitchPerfectUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRecording() {
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        
        XCTAssert(app.staticTexts["Tap to Record"].exists)
        app.buttons["Record"].tap()
        XCTAssert(app.staticTexts["Recording in Progress"].exists)
        app.buttons["Stop1"].tap()
        app.navigationBars["ChangeVoiceViewController"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        XCTAssert(app.staticTexts["Tap to Record"].exists)

    }
    
    func testButtonState_ChangeVoiceViewController(){
        XCUIDevice.shared().orientation = .portrait
        
        let app = XCUIApplication()
        app.buttons["Record"].tap()
        app.buttons["Stop1"].tap()
        XCTAssert(app.buttons["Echo"].isEnabled, "Disabled")
        XCTAssert(!app.buttons["Stop2"].isEnabled, "Enabled")
        app.buttons["Echo"].tap()
        XCTAssert(!app.buttons["Echo"].isEnabled, "Enabled")
        XCTAssert(app.buttons["Stop2"].isEnabled, "Disabled")
        app.buttons["Stop2"].tap()
        XCTAssert(app.buttons["Echo"].isEnabled, "Disabled")
        XCTAssert(!app.buttons["Stop2"].isEnabled, "Enabled")
        
    }
    
    func testNavigation(){
        XCUIDevice.shared().orientation = .portrait
        let app = XCUIApplication()
        let recordButton = app.buttons["Record"]
        let stopButton = app.buttons["Stop1"]
        recordButton.tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "RecordSoundViewController")
        stopButton.tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "ChangeVoiceViewController")
        app.navigationBars["ChangeVoiceViewController"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0).tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "RecordSoundViewController")
    }
    
    func testButtonStates() {
        XCUIDevice.shared().orientation = .portrait
        let app = XCUIApplication()
        let recordButton = app.buttons["Record"]
        let stopButton = app.buttons["Stop1"]
        XCTAssert(recordButton.isEnabled, "Enabled")
        XCTAssert(!stopButton.isEnabled, "Disabled")
        recordButton.tap()
        XCTAssert(!recordButton.isEnabled, "Disabled")
        XCTAssert(stopButton.isEnabled, "Enabled")
        stopButton.tap()
        XCTAssert(recordButton.isEnabled, "Enabled")
    }
    
    func testOrientation() {
        XCUIDevice.shared().orientation = .portrait
        let element = XCUIApplication().otherElements.containing(.navigationBar, identifier:"RecordSoundViewController").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        XCTAssert(UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation), "Test failed")

        XCUIDevice.shared().orientation = .portraitUpsideDown
        element.tap()
        XCTAssert(UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation), "Test failed")

        XCUIDevice.shared().orientation = .portrait
        element.tap()
        XCTAssert(UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation), "Test failed")
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
