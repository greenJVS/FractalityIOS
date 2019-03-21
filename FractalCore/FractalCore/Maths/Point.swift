//
//  Point.swift
//  FractalCore
//
//  Created by Admin on 21/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

/// Point structure with 3 coordinates.
struct Point {
	
	let x: Double
	let y: Double
	let z: Double
	
	/// Returns a point based on specified coordinates
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
}
