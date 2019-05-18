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
	
	func testIterationRule_Initialization_RightInput() {
		let iterationRule = IterationRule(
			relativeVectors: [Vector(), Vector()],
			beams: [
			IterationRule.Beam(startNode: 0, endNode: 1, isIterable: true),
			IterationRule.Beam(startNode: 1, endNode: 2, isIterable: true),
			IterationRule.Beam(startNode: 1, endNode: 2, isIterable: true)
			]
		)
		
		XCTAssertEqual(iterationRule.relativeVectors.count, 2)
		XCTAssertEqual(iterationRule.beams.count, 3)
	}
	
}
