//
//  CoordinateSystem.swift
//  FractalCore
//
//  Created by Admin on 23/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

struct CoordinateSystem {
	
	let basis1, basis2, basis3: Vector
	let origin: Point
	
	init(origin: Point = Point(),
		 basis1: Vector = Vector(),
		 basis2: Vector = Vector(),
		 basis3: Vector = Vector()) {
		self.origin = origin
		self.basis1 = basis1
		self.basis2 = basis2
		self.basis3 = basis3
	}
	
	func transitionMatrix(toCoordinateSystem coordinateSystem: CoordinateSystem) -> Matrix2D? {
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
