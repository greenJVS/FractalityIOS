//
//  BeamTests.swift
//  FractalCoreTests
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class BeamTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: Initialization

extension BeamTests {
	
	func testBeam_Initialization_DefaultIterable() {
		
		let beam = Beam(
			startNode: Node(point: Point(x: 1, y: 2, z: 3)),
			endNode: Node(point: Point(x: 4, y: 5, z: 6))
		)
		
		XCTAssertEqual(beam.isIterable, true)
		XCTAssertEqual(beam.startNode?.point.x, 1)
		XCTAssertEqual(beam.startNode?.point.y, 2)
		XCTAssertEqual(beam.startNode?.point.z, 3)
		
		XCTAssertEqual(beam.endNode?.point.x, 4)
		XCTAssertEqual(beam.endNode?.point.y, 5)
		XCTAssertEqual(beam.endNode?.point.z, 6)
	}
	
	func testBeam_Initialization_GivenIterable() {
		
		let beam = Beam(
			startNode: Node(point: Point(x: 1, y: 2, z: 3)),
			endNode: Node(point: Point(x: 4, y: 5, z: 6)),
			isIterable: false
		)
		
		XCTAssertEqual(beam.isIterable, false)
		XCTAssertEqual(beam.startNode?.point.x, 1)
		XCTAssertEqual(beam.startNode?.point.y, 2)
		XCTAssertEqual(beam.startNode?.point.z, 3)
		
		XCTAssertEqual(beam.endNode?.point.x, 4)
		XCTAssertEqual(beam.endNode?.point.y, 5)
		XCTAssertEqual(beam.endNode?.point.z, 6)
	}
	
}
