//
//  ErrorHierarchyUITests.swift
//  ErrorHierarchyUITests
//
//  Created by Emilio Peláez on 8/1/22.
//

import XCTest

class ErrorHierarchyUITests: XCTestCase {
	override func setUpWithError() throws {
		continueAfterFailure = false
	}
	
	override func tearDownWithError() throws {
	}
	
	func testExample() throws {
		let app = XCUIApplication()
		app.launch()
		
		app.buttons["Test 1"].tap()
		
		XCTAssert(app.alerts["Test 1"].exists)
		
		app.buttons["Close"].tap()
		
		app.buttons["Test 2"].tap()
		
		XCTAssert(app.alerts["Test 2"].exists)
		
		app.buttons["Close"].tap()
		
		app.buttons["Test 3"].tap()
		
		XCTAssert(app.alerts["Error"].staticTexts["Test 3"].exists)
		
		app.buttons["Okay"].tap()
		
		app.buttons["Test 4"].tap()
	}
}
