//
//  Node.swift
//  FractalCore
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

/// Node with Point and Number.
class Node {
	
	let point: Point
	var number: Int = 0
	
	/// Return a Node based on given Point.
	///
	/// - Parameter point: Point.
	init(point: Point = Point()) {
		self.point = point
	}
	
	/// Returns a new Node with added amoount of the point to each coordinate.
	///
	/// - Parameter point: The Point to shift coordinates.
	/// - Returns: Shifted Node.
	func shifted(by point: Point) -> Node {
		let newPoint = Point(
			x: self.point.x + point.x,
			y: self.point.y + point.y,
			z: self.point.z + point.z
		)
		let node = Node(point: newPoint)
		node.number = self.number
		return node
	}
	
}
