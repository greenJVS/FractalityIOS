//
//  VectorTests.swift
//  FractalCoreTests
//
//  Created by Admin on 21/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class VectorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testVectorInitialization_ZeroCoordinates() {
		let point = Vector()
		
		XCTAssertEqual(point.x, 0)
		XCTAssertEqual(point.y, 0)
		XCTAssertEqual(point.z, 0)
	}
	
	func testVectorInitialization_CopyInstanceVars() {
		let point = Vector(x: 1, y: 2, z: 3)
		
		XCTAssertEqual(point.x, 1)
		XCTAssertEqual(point.y, 2)
		XCTAssertEqual(point.z, 3)
	}
	
	func testVectorInitialization_TwoPoints() {
		let point1 = Point(x: 4, y: 5, z: 8)
		let point2 = Point(x: 1, y: 15, z: 3)
		
		let vector = Vector(fromPoint: point1, to: point2)
		
		XCTAssertEqual(vector.x, -3)
		XCTAssertEqual(vector.y, 10)
		XCTAssertEqual(vector.z, -5)
	}
	
	func testVector_Length() {
		let zeroVector = Vector()
		let nonZeroVector = Vector(x: 3, y: 4, z: 5)
		let unitVector = Vector(x: 1, y: 0, z: 0)
		
		XCTAssertEqual(zeroVector.length, 0)
		XCTAssertNotEqual(nonZeroVector.length, 0)
		XCTAssertEqual(unitVector.length, 1)
	}
	
	func testVector_Normalized() {
		let zeroVector = Vector()
		let nonZeroVector = Vector(x: 3, y: 4, z: 5)
		
		let normalizedZeroVector = zeroVector.normalized()
		let normalizedNonZeroVector = nonZeroVector.normalized()
		
		XCTAssertNil(normalizedZeroVector)
		XCTAssertNotNil(normalizedNonZeroVector)
		XCTAssertEqual(normalizedNonZeroVector!.length, 1)
	}
	
	// MARK: Multiplication
	
	func testVector_Multiplication_ByZero() {
		var zeroVector = Vector()
		var nonZeroVector = Vector(x: 1, y: -2, z: -3)
		
		zeroVector.multiply(by: 0)
		nonZeroVector.multiply(by: 0)
		
		XCTAssertEqual(zeroVector.length, 0)
		XCTAssertEqual(nonZeroVector.length, 0)
	}
	
	func testVector_Multiplication_ByValue() {
		var zeroVector = Vector()
		var nonZeroVector = Vector(x: 1, y: -2, z: -3)
		
		zeroVector.multiply(by: 2)
		nonZeroVector.multiply(by: -5)
		
		XCTAssertEqual(zeroVector.length, 0)
		XCTAssertNotEqual(nonZeroVector.length, 0)
	}
	
	// MARK: Product
	
	func testVector_Product_WithZeroVector() {
		let zeroVector = Vector()
		let nonZeroVector = Vector(x: -5, y: -1, z: 12)
		
		let productVector = zeroVector.producted(with: nonZeroVector)//Vector.product(zeroVector, with: nonZeroVector)
		
		XCTAssertEqual(productVector.length, 0)
	}

	func testVector_Profuct_NonZeroVectors() {
		let xVector = Vector(x: 1, y: 0, z: 0)
		let yVector = Vector(x: 0, y: 1, z: 0)
		let zVector = Vector(x: 0, y: 0, z: 1)
		
		let xyVector = xVector.producted(with: yVector)
		let yxVector = yVector.producted(with: xVector)
		
		let yzVector = yVector.producted(with: zVector)
		let zyVector = zVector.producted(with: yVector)
		
		let zxVector = zVector.producted(with: xVector)
		let xzVector = xVector.producted(with: zVector)
		
		// Vector lengths
		XCTAssertEqual(xyVector.length, 1)
		XCTAssertEqual(yxVector.length, 1)
		XCTAssertEqual(yzVector.length, 1)
		XCTAssertEqual(zyVector.length, 1)
		XCTAssertEqual(zxVector.length, 1)
		XCTAssertEqual(xzVector.length, 1)
		
		// Directions
		XCTAssertEqual(xyVector.z, 1)
		XCTAssertEqual(yxVector.z, -1)
		XCTAssertEqual(yzVector.x, 1)
		XCTAssertEqual(zyVector.x, -1)
		XCTAssertEqual(zxVector.y, 1)
		XCTAssertEqual(xzVector.y, -1)
	}
	
	// MARK: Orthogonal vectors
	
	func testVector_Orthogonal_IsNormalized() {
		let zeroVector = Vector()
		let orthogonalZeroVector = zeroVector.orthogonalVector()
		
		let nonZeroVector = Vector(x: -1, y: 5, z: 7)
		let orthogonalNonZeroVector = nonZeroVector.orthogonalVector()

		let zVector = Vector(x: 0, y: 0, z: 1)
		let orthogonalZVector = zVector.orthogonalVector()
		
		let minusZVector = Vector(x: 0, y: 0, z: -1)
		let orthogonalMinusZVector = minusZVector.orthogonalVector()
		
		XCTAssertEqual(orthogonalZeroVector.length, 1)
		XCTAssertEqual(orthogonalNonZeroVector.length, 1)
		XCTAssertEqual(orthogonalZVector.length, 1)
		XCTAssertEqual(orthogonalMinusZVector.length, 1)
	}
	
	
}
