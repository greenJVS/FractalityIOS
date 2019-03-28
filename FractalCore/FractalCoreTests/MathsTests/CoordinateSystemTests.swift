//
//  CoordinateSystemTests.swift
//  FractalCoreTests
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class CoordinateSystemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: Initialization

extension CoordinateSystemTests {
	
	func testCoordinateSystem_Initialization_DefaultArgs() {
		let zeroCoordinateSystem = CoordinateSystem()
		
		XCTAssertEqual(zeroCoordinateSystem.origin.x, 0)
		XCTAssertEqual(zeroCoordinateSystem.origin.y, 0)
		XCTAssertEqual(zeroCoordinateSystem.origin.z, 0)
		
		XCTAssertEqual(zeroCoordinateSystem.basis1.x, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis1.y, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis1.z, 0)
		
		XCTAssertEqual(zeroCoordinateSystem.basis2.x, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis2.y, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis2.z, 0)
		
		XCTAssertEqual(zeroCoordinateSystem.basis3.x, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis3.y, 0)
		XCTAssertEqual(zeroCoordinateSystem.basis3.z, 0)
	}
	
	func testCoordinateSystem_Initialization_CustomArgs() {
		let origin = Point(x: 1, y: 2, z: -5)
		let basis1 = Vector(x: 7, y: -1, z: 0.5)
		let basis2 = Vector(x: 0, y: 2, z: 4)
		let basis3 = Vector(x: -3, y: 0.7, z: 0)
		
		let coordinateSystem = CoordinateSystem(
			origin: origin,
			basis1: basis1,
			basis2: basis2,
			basis3: basis3
		)
		
		XCTAssertEqual(coordinateSystem.origin.x, 1)
		XCTAssertEqual(coordinateSystem.origin.y, 2)
		XCTAssertEqual(coordinateSystem.origin.z, -5)
		
		XCTAssertEqual(coordinateSystem.basis1.x, 7)
		XCTAssertEqual(coordinateSystem.basis1.y, -1)
		XCTAssertEqual(coordinateSystem.basis1.z, 0.5)
		
		XCTAssertEqual(coordinateSystem.basis2.x, 0)
		XCTAssertEqual(coordinateSystem.basis2.y, 2)
		XCTAssertEqual(coordinateSystem.basis2.z, 4)
		
		XCTAssertEqual(coordinateSystem.basis3.x, -3)
		XCTAssertEqual(coordinateSystem.basis3.y, 0.7)
		XCTAssertEqual(coordinateSystem.basis3.z, 0)
	}
	
}

// MARK: TransitionMatrix

extension CoordinateSystemTests {
	
	func testCoordinateSystem_TransitionMatrix_WrongInput() {
		let zeroCoordinateSystem = CoordinateSystem()
		
		let origin = Point(x: 1, y: 2, z: -5)
		let basis1 = Vector(x: 7, y: -1, z: 0.5)
		let basis2 = Vector(x: 0, y: 2, z: 4)
		let basis3 = Vector(x: -3, y: 0.7, z: 0)
		
		let nonZeroCoordinateSystem = CoordinateSystem(
			origin: origin,
			basis1: basis1,
			basis2: basis2,
			basis3: basis3
		)
		
		let transitionMatrixFromZero = zeroCoordinateSystem.transitionMatrix(to: nonZeroCoordinateSystem)
		let transitionMatrixFromNonZero = nonZeroCoordinateSystem.transitionMatrix(to: zeroCoordinateSystem)
		
		XCTAssertNil(transitionMatrixFromZero)
		XCTAssertNotNil(transitionMatrixFromNonZero)
	}
	
	func testCoordinateSystem_TransitionMatrix_RightInput() {
		let originA = Point()
		let basis1A = Vector(x: 1, y: 0, z: 0)
		let basis2A = Vector(x: 0, y: 1, z: 0)
		let basis3A = Vector(x: 0, y: 0, z: 1)
		
		let coordinateSystemA = CoordinateSystem(
			origin: originA,
			basis1: basis1A,
			basis2: basis2A,
			basis3: basis3A
		)
		
		let originB = Point()
		let basis1B = Vector(x: 1, y: 1, z: 1)
		let basis2B = Vector(x: 1, y: 2, z: 1)
		let basis3B = Vector(x: 1, y: 2, z: 2)
		
		let coordinateSystemB = CoordinateSystem(
			origin: originB,
			basis1: basis1B,
			basis2: basis2B,
			basis3: basis3B
		)
		
		let transitionMatrix = coordinateSystemA.transitionMatrix(to: coordinateSystemB)
		
		XCTAssertNotNil(transitionMatrix)
		
		XCTAssertEqual(transitionMatrix![0][0], 1)
		XCTAssertEqual(transitionMatrix![0][1], 1)
		XCTAssertEqual(transitionMatrix![0][2], 1)
		
		XCTAssertEqual(transitionMatrix![1][0], 1)
		XCTAssertEqual(transitionMatrix![1][1], 2)
		XCTAssertEqual(transitionMatrix![1][2], 2)
		
		XCTAssertEqual(transitionMatrix![2][0], 1)
		XCTAssertEqual(transitionMatrix![2][1], 1)
		XCTAssertEqual(transitionMatrix![2][2], 2)
		
	}
	
}
