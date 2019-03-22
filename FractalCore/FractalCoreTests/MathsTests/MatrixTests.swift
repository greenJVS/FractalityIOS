//
//  MatrixTests.swift
//  FractalCoreTests
//
//  Created by Admin on 22/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class MatrixTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: Initialization

extension MatrixTests {
	
	func testMatrix_Initialization_WrongInputParams() {
		let wrongMatrix1 = Matrix2D(rows: 0, columns: 1)
		let wrongMatrix2 = Matrix2D(rows: 1, columns: 0)
		let wrongMatrix3 = Matrix2D(rows: 0, columns: 0)
		let wrongMatrix4 = Matrix2D(rows: -1, columns: 1)
		let wrongMatrix5 = Matrix2D(rows: 14, columns: -54)
		
		XCTAssertNil(wrongMatrix1)
		XCTAssertNil(wrongMatrix2)
		XCTAssertNil(wrongMatrix3)
		XCTAssertNil(wrongMatrix4)
		XCTAssertNil(wrongMatrix5)
	}
	
	func testMatrix_Initialization_RightParams() {
		let rightMatrix1 = Matrix2D(rows: 1, columns: 1)
		let rightMatrix2 = Matrix2D(rows: 10, columns: 3)
		let rightMatrix3 = Matrix2D(rows: 4, columns: 4)
		
		XCTAssertNotNil(rightMatrix1)
		XCTAssertNotNil(rightMatrix2)
		XCTAssertNotNil(rightMatrix3)
	}
	
	func testMatrix_Initialization_NumberOfRowsAndColumns() {
		let matrix = Matrix2D(rows: 4, columns: 5)!
		
		XCTAssertEqual(matrix.count, 4)
		XCTAssertEqual(matrix[0].count, 5)
		XCTAssertEqual(matrix[1].count, 5)
		XCTAssertEqual(matrix[2].count, 5)
		XCTAssertEqual(matrix[3].count, 5)
	}
	
}

// MARK: Product

extension MatrixTests {
	
	func testMatrix_Product_WrongInputParams() {
		let wrongMatrix = Matrix2D(rows: 1, columns: 1)!
		let validMatrix = Matrix2D(rows: 2, columns: 2)!
		
		let product1 = wrongMatrix.producted(with: validMatrix)
		let product2 = validMatrix.producted(with: wrongMatrix)
		
		XCTAssertNil(product1)
		XCTAssertNil(product2)
	}
	
	func testMatrix_Product_One() {
		let rowA1: Matrix1D = [2, 0, 4, -1]
		let rowA2: Matrix1D = [1, -1, 1, 0]
		var matrixA = Matrix2D(rows: 2, columns: 4)!
		matrixA[0] = rowA1
		matrixA[1] = rowA2
		
		var matrixB = Matrix2D(rows: 4, columns: 1)!
		matrixB[0] = [2]
		matrixB[1] = [1]
		matrixB[2] = [0]
		matrixB[3] = [-2]
		
		let productAB = matrixA.producted(with: matrixB)
		let productBA = matrixB.producted(with: matrixA)
		
		XCTAssertNotNil(productAB)
		XCTAssertEqual(productAB!.count, 2)
		XCTAssertEqual(productAB![0].count, 1)
		XCTAssertEqual(productAB![1].count, 1)
		XCTAssertEqual(productAB![0][0], 6)
		XCTAssertEqual(productAB![1][0], 1)
		
		XCTAssertNil(productBA)
	}
	
	func testMatrix_Product_Two() {
		let rowA1: Matrix1D = [-1, 1]
		let rowA2: Matrix1D = [2, 0]
		let rowA3: Matrix1D = [0, 3]
		var matrixA = Matrix2D(rows: 3, columns: 2)!
		matrixA[0] = rowA1
		matrixA[1] = rowA2
		matrixA[2] = rowA3
		
		let rowB1: Matrix1D = [3, 1, 2]
		let rowB2: Matrix1D = [0, -1, 4]
		var matrixB = Matrix2D(rows: 2, columns: 3)!
		matrixB[0] = rowB1
		matrixB[1] = rowB2
		
		let productAB = matrixA.producted(with: matrixB)
		let productBA = matrixB.producted(with: matrixA)
		
		XCTAssertNotNil(productAB)
		XCTAssertEqual(productAB!.count, 3)
		XCTAssertEqual(productAB![0].count, 3)
		
		XCTAssertEqual(productAB![0][0], -3)
		XCTAssertEqual(productAB![1][0], 6)
		XCTAssertEqual(productAB![2][0], 0)
		
		XCTAssertEqual(productAB![0][1], -2)
		XCTAssertEqual(productAB![1][1], 2)
		XCTAssertEqual(productAB![2][1], -3)
		
		XCTAssertEqual(productAB![0][2], 2)
		XCTAssertEqual(productAB![1][2], 4)
		XCTAssertEqual(productAB![2][2], 12)
		
		XCTAssertNotNil(productBA)
		XCTAssertEqual(productBA!.count, 2)
		XCTAssertEqual(productBA![0].count, 2)
		
		XCTAssertEqual(productBA![0][0], -1)
		XCTAssertEqual(productBA![1][0], -2)
		
		XCTAssertEqual(productBA![0][1], 9)
		XCTAssertEqual(productBA![1][1], 12)
	}
}

// MARK: Inversion

extension MatrixTests {
	
	func testMatrix_Inversion_ZeroDeterminantMatrix() {
		let rowA1: Matrix1D = [1, 2]
		let rowA2: Matrix1D = [2, 4]
		var matrixA = Matrix2D(rows: 2, columns: 2)!
		matrixA[0] = rowA1
		matrixA[1] = rowA2
		
		let inversedMatrix = matrixA.inversed()
		
		XCTAssertNil(inversedMatrix)
	}
	
	func testMatrix_Inversion_NotSquareMatrix() {
		let rowB1: Matrix1D = [3, 1, 2]
		let rowB2: Matrix1D = [0, -1, 4]
		var matrixB = Matrix2D(rows: 2, columns: 3)!
		matrixB[0] = rowB1
		matrixB[1] = rowB2
		
		let inversedMatrix = matrixB.inversed()
		
		XCTAssertNil(inversedMatrix)
	}
	
	func testMatrix_Inversion_One() {
		let rowA1: Matrix1D = [1, 1]
		let rowA2: Matrix1D = [1, 2]
		var matrixA = Matrix2D(rows: 2, columns: 2)!
		matrixA[0] = rowA1
		matrixA[1] = rowA2
		
		let inversedMatrix = matrixA.inversed()
		
		XCTAssertNotNil(inversedMatrix)
		XCTAssertEqual(matrixA.count, inversedMatrix!.count)
		XCTAssertEqual(matrixA[0].count, inversedMatrix![0].count)
		XCTAssertEqual(matrixA[1].count, inversedMatrix![0].count)
		
		XCTAssertEqual(inversedMatrix![0][0], 2)
		XCTAssertEqual(inversedMatrix![1][0], -1)
		
		XCTAssertEqual(inversedMatrix![0][1], -1)
		XCTAssertEqual(inversedMatrix![1][1], 1)
	}
	
}
