//
//  NodeTests.swift
//  FractalCoreTests
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class NodeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: Initialization

extension NodeTests {
	
	func testNode_Initialization_DefaultArgs() {
		let zeroNode = Node()
		
		XCTAssertEqual(zeroNode.point.x, 0)
		XCTAssertEqual(zeroNode.point.y, 0)
		XCTAssertEqual(zeroNode.point.z, 0)
		XCTAssertEqual(zeroNode.number, 0)
	}
	
	func testNode_Initialization_CustomArgs() {
		let nonZeroNode = Node(point: Point(x: 1, y: -5, z: 3))
		nonZeroNode.number = 5
		
		XCTAssertEqual(nonZeroNode.point.x, 1)
		XCTAssertEqual(nonZeroNode.point.y, -5)
		XCTAssertEqual(nonZeroNode.point.z, 3)
		XCTAssertEqual(nonZeroNode.number, 5)
	}
	
}

// MARK: Shifting

extension NodeTests {
	
	func testNode_Shifting_ZeroPoint() {
		let nonZeroNode = Node(point: Point(x: 1, y: -5, z: 3))
		nonZeroNode.number = 5
		
		let shiftedNode = nonZeroNode.shifted(by: Point())
		
		XCTAssertFalse(nonZeroNode === shiftedNode)
		XCTAssertEqual(shiftedNode.point.x, 1)
		XCTAssertEqual(shiftedNode.point.y, -5)
		XCTAssertEqual(shiftedNode.point.z, 3)
		XCTAssertEqual(shiftedNode.number, 5)
	}
	
	func testNode_Shifting_NonZeroPoint() {
		let nonZeroNode = Node(point: Point(x: 1, y: -5, z: 3))
		nonZeroNode.number = 5
		
		let shiftedNode = nonZeroNode.shifted(by: Point(x: 2, y: -1, z: -5))
		
		XCTAssertEqual(shiftedNode.point.x, 3)
		XCTAssertEqual(shiftedNode.point.y, -6)
		XCTAssertEqual(shiftedNode.point.z, -2)
		XCTAssertEqual(shiftedNode.number, 5)
	}
	
}
