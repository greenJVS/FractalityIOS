//
//  Vector.swift
//  FractalCore
//
//  Created by Admin on 21/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

/// Vector structure with 3 coordinates.
public struct Vector {
	
	var x, y, z: Double
	
	/// Returns the length of the vector.
	var length: Double {
		let length = sqrt(x * x + y * y + z * z)
		let divisor = pow(10.0, Double(15))
		return (length * divisor).rounded() / divisor
	}
	
	/// Returns a vector based on specified coordinates
	///
	/// - Parameters:
	///   - x: X coordinate.
	///   - y: Y coordinate.
	///   - z: Z coordinate.
	init(x: Double = 0, y: Double = 0, z: Double = 0) {
		self.x = x
		self.y = y
		self.z = z
	}
	
	/// Returns a vector based on two points.
	///
	/// - Parameters:
	///   - startPoint: Start point.
	///   - endPoint: End point.
	init(fromPoint startPoint: Point, to endPoint: Point) {
		x = endPoint.x - startPoint.x
		y = endPoint.y - startPoint.y
		z = endPoint.z - startPoint.z
	}
	
	/// Returns a new vector obtained by a product with a given vector.
	///
	/// - Parameter vector: Vector for product.
	/// - Returns: Vector product.
	func producted(with vector: Vector) -> Vector {
		let x = self.y * vector.z - self.z * vector.y
		let y = self.z * vector.x - self.x * vector.z
		let z = self.x * vector.y - self.y * vector.x
		
		return Vector(x: x, y: y, z: z)
	}
	
	/// Returns a normalized unit vector.
	///
	/// - Returns: Normalized vector. Returns nil for zero vectors.
	func normalized() -> Vector? {
		let length = self.length
		
		guard length != 0 else {
			return nil
		}
		
		return Vector(x: x / length, y: y / length, z: z / length)
	}
	
	/// This method multiplies each coordinate of the vector by a specified value.
	///
	/// - Parameter value: Value for multiplication
	mutating func multiply(by value: Double) {
		x *= value
		y *= value
		z *= value
	}
	
	/// Returns an normalized orthogonal vector oriented by the principle of the right coordinate system.
	///
	/// - Returns: Orthogonal vector.
	func orthogonalVector() -> Vector {
		
		let zVector = Vector(x: 0, y: 0, z: 1)
		let orthogonalVector = zVector.producted(with: self)
		
		if orthogonalVector.length == 0 {
			let x = z < 0 ? -1.0 : 1.0
			return Vector(x: x, y: 0, z: 0).normalized()!
		}
		
		return orthogonalVector.normalized()!
	}
}
