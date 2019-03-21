//
//  PointTests.swift
//  FractalCoreTests
//
//  Created by Admin on 21/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class PointTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testPointInitialization_ZeroCoordinates() {
		let point = Point()
		
		XCTAssertEqual(point.x, 0)
		XCTAssertEqual(point.y, 0)
		XCTAssertEqual(point.z, 0)
	}
	
	func testPointInitialization_CopyInstanceVars() {
		let point = Point(x: 1, y: 2, z: 3)
		
		XCTAssertEqual(point.x, 1)
		XCTAssertEqual(point.y, 2)
		XCTAssertEqual(point.z, 3)
	}
	
}
