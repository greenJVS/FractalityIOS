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
typealias Matrix2D = [Matrix1D]

extension Matrix2D {
	
	init?(rows: Int, columns: Int) {
		guard rows > 0 && columns > 0 else {
			return nil
		}
		let row: Matrix1D = .init(repeating: 0, count: rows)
		self = Matrix2D.init(repeating: row, count: columns)
	}
	
	func product(with matrix: Matrix2D) -> Matrix2D? {
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
					result[i][j] = self[i][k] * matrix[k][j]
				}
			}
		}
		
		return result
	}
	
	private func decomposed() -> (matrix: Matrix2D, perm: [Int])? {
		guard self.count > 0, self.count == self[0].count else { return nil }
		
		let length = self.count
		var result = self
		var perm = (0..<length).map({ $0 })
		var toggle = true
		
		for j in 0..<length - 1 {
			var columnMax = abs(result[j][j])
			var pRow = j
			
			for i in (j + 1)..<length {
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
				toggle.toggle()
			}
			
			guard abs(result[j][j]) > 0 else {
				return nil
			}
			
			for i in (j + 1)..<length {
				result[i][j] /= result[j][j]
				
				for k in (j + 1)..<length {
					result[i][k] -= result[i][j] * result[j][k]
				}
			}
		}
		
		return (result, perm)
	}
	
	private func helperSolve(with vector: Matrix1D) -> Matrix1D {
		let length = self.count
		var x = vector
		
		for i in 1..<length {
			var sum = x[i]
			for j in 0..<i {
				sum -= self[i][j] * x[j]
			}
			x[i] = sum
		}
		
		x[length - 1] /= self[length - 1][length - 1]
		
		var i = length - 2
		while i >= 0 {
			var sum = x[i]
			
			for j in (i + 1)..<length {
				sum -= self[i][j] * x[j]
			}
			
			x[i] = sum / self[i][i]
			
			i -= 1
		}
		
		return x
	}
	
}


