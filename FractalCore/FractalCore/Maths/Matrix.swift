//
//  Matrix.swift
//  FractalCore
//
//  Created by Admin on 22/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//
// https://github.com/greenJVS/Fractality/blob/master/FractalUWP/Fractal/Maths/Matrix.cs
//

import Foundation

typealias Matrix1D = [Double]

struct Matrix2D {
	
	private let columnsCount: Int
	
	private var rows: [Matrix1D]
	
	/// Return the number of rows.
	let count: Int
	
	/// Creates a new matrix with a specified number of rows and columns.
	/// Returns nil when number of rows or columns is not greater than zero.
	///
	/// - Parameters:
	///   - rows: Number of rows.
	///   - columns: Number of columns.
	init?(rows: Int, columns: Int, repeating value: Double = 0.0) {
		guard rows > 0 && columns > 0 else { return nil }
		
		let row: Matrix1D = .init(repeating: value, count: columns)
		self.rows = [Matrix1D].init(repeating: row, count: rows)
		self.columnsCount = columns
		self.count = rows
	}
	
	/// Returns the matrix obtained by the product with the given one.
	///
	/// - Parameter matrix: Matrix for product.
	/// - Returns: Matrix product.
	func producted(with matrix: Matrix2D) -> Matrix2D? {
		let aRows = self.count
		let aCols = self[0].count
		let bRows = matrix.count
		let bCols = matrix[0].count
		
		guard aCols == bRows, var result = Matrix2D(rows: aRows, columns: bCols) else  {
			print("FractalCore: Non-conformable or zero matrices in MatrixProduct")
			return nil
		}
		
		for i in 0..<aRows {
			for j in 0..<bCols {
				for k in 0..<aCols {
					result[i][j] += self[i][k] * matrix[k][j]
				}
			}
		}
		
		return result
	}
	
	/// Returns a inversed matrix.
	///
	/// - Returns: Inversed matrix.
	func inversed() -> Matrix2D? {
		let n = self.count
		var result = self
		
		guard let decomposed = self.decomposed() else { return nil }
		
		let lumMatrix = decomposed.matrix
		var determinant = Double(decomposed.toggle)
		for i in 0..<lumMatrix.count {
			determinant *= lumMatrix[i][i]
		}
		guard determinant != 0 else { return nil }
		
		let perm = decomposed.perm
		var b = Matrix1D.init(repeating: 0.0, count: n)
		
		for i in 0..<n {
			for j in 0..<n {
				b[j] = i == perm[j] ? 1 : 0
			}
			let x = lumMatrix.helperSolve(with: b)
			
			for j in 0..<n {
				result[j][i] = x[j]
			}
		}
		
		return result
	}
	
	/// A row at a given index
	///
	/// - Parameter index: Index of row.
	subscript(index: Int) -> Matrix1D {
		get {
			return rows[index]
		}
		set {
			if newValue.count == columnsCount {
				rows[index] = newValue
			}
		}
	}
	
	// Returns a tuple with decomposed matrix and perm.
	private func decomposed() -> (matrix: Matrix2D, perm: [Int], toggle: Int)? {
		guard self.count > 0, self.count == self[0].count else { return nil }
		
		let n = self.count
		var result = self
		var perm = (0..<n).map({ $0 })
		var toggle = 1
		
		for j in 0..<n - 1 {
			var columnMax = abs(result[j][j])
			var pRow = j
			
			for i in (j + 1)..<n {
				let current = abs(result[i][j])
				
				if current > columnMax {
					columnMax = current
					pRow = i
				}
			}
			
			if pRow != j {
				let rowPtr = result[pRow]
				result[pRow] = result[j]
				result[j] = rowPtr
				
				let tmp = perm[pRow]
				perm[pRow] = perm[j]
				perm[j] = tmp
				toggle = -toggle
			}
			
			guard abs(result[j][j]) > 0 else {
				return nil
			}
			
			for i in (j + 1)..<n {
				result[i][j] /= result[j][j]
				
				for k in (j + 1)..<n {
					result[i][k] -= result[i][j] * result[j][k]
				}
			}
		}
		
		return (result, perm, toggle)
	}
	
	// Helper for solve inversed matrix.
	private func helperSolve(with vector: Matrix1D) -> Matrix1D {
		let n = self.count
		var x = vector
		
		for i in 1..<n {
			var sum = x[i]
			for j in 0..<i {
				sum -= self[i][j] * x[j]
			}
			x[i] = sum
		}
		
		x[n - 1] /= self[n - 1][n - 1]
		
		var i = n - 2
		while i >= 0 {
			var sum = x[i]
			for j in (i + 1)..<n {
				sum -= self[i][j] * x[j]
			}
			x[i] = sum / self[i][i]
			
			i -= 1
		}
		
		return x
	}
	
}


