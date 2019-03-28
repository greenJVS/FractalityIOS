//
//  IterationRuleTests.swift
//  FractalCoreTests
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class IterationRuleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: Initialization

extension IterationRuleTests {
	
	func testIterationRule_Initialization_WrongInput() {
		let iterationRule = IterationRule(relativeVectors: [], beams: [[0], [1, 2], [1, 2, 3]])
		
		XCTAssertNil(iterationRule)
	}
	
	func testIterationRule_Initialization_RightInput() {
		let iterationRule = IterationRule(
			relativeVectors: [Vector(), Vector()],
			beams: [[0, 1, 2], [1, 2, 5], [1, 2, 3]]
		)
		
		XCTAssertNotNil(iterationRule)
		XCTAssertEqual(iterationRule?.relativeVectors.count, 2)
		XCTAssertEqual(iterationRule?.beams.count, 3)
	}
	
}
