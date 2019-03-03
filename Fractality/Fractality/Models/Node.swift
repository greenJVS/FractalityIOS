//
//  Node.swift
//  Fractality
//
//  Created by Admin on 01/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

class Node {
	var number: Int
	var x: Double
	var y: Double
	var z: Double
	
	init(number: Int = 0, x: Double, y: Double, z: Double) {
		self.number = number
		self.x = x
		self.y = y
		self.z = z
	}
}
