//
//  CoordinateSystem.swift
//  FractalCore
//
//  Created by Admin on 23/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

/// Coordinate System with three basises vectors and origin point.
struct CoordinateSystem {
	
	let basis1, basis2, basis3: Vector
	let origin: Point
	
	/// Returns a default Global Coordinate System.
	init() {
		self.origin = Point()
		self.basis1 = Vector(x: 1, y: 0, z: 0)
		self.basis2 = Vector(x: 0, y: 1, z: 0)
		self.basis3 = Vector(x: 0, y: 0, z: 1)
	}
	
	/// Returns a Coordinate System based on three basises and origin.
	///
	/// - Parameters:
	///   - origin: Origin Point.
	///   - basis1: First Basis vector.
	///   - basis2: Second Basis vector.
	///   - basis3: Third Basis vector.
	init(origin: Point,
		 basis1: Vector,
		 basis2: Vector,
		 basis3: Vector) {
		self.origin = origin
		self.basis1 = basis1
		self.basis2 = basis2
		self.basis3 = basis3
	}
	
	/// Returns a transition matrix to specified coordinate system.
	///
	/// - Parameter coordinateSystem: Target coordinate system.
	/// - Returns: Transition Matrix.
	func transitionMatrix(to coordinateSystem: CoordinateSystem) -> Matrix2D? {
		var mG = Matrix2D(rows: 3, columns: 3)!
		mG[0][0] = basis1.x
		mG[1][0] = basis1.y
		mG[2][0] = basis1.z
		
		mG[0][1] = basis2.x
		mG[1][1] = basis2.y
		mG[2][1] = basis2.z
		
		mG[0][2] = basis3.x
		mG[1][2] = basis3.y
		mG[2][2] = basis3.z
		
		var mF = Matrix2D(rows: 3, columns: 3)!
		mF[0][0] = coordinateSystem.basis1.x
		mF[1][0] = coordinateSystem.basis1.y
		mF[2][0] = coordinateSystem.basis1.z
		
		mF[0][1] = coordinateSystem.basis2.x
		mF[1][1] = coordinateSystem.basis2.y
		mF[2][1] = coordinateSystem.basis2.z
		
		mF[0][2] = coordinateSystem.basis3.x
		mF[1][2] = coordinateSystem.basis3.y
		mF[2][2] = coordinateSystem.basis3.z
		
		if let mGInv = mG.inversed() {
			return mGInv.producted(with: mF)
		}
		
		return nil
	}
}
