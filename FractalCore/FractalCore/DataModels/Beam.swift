//
//  Beam.swift
//  FractalCore
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

/// Beam with Start Node, End Node and isIterable property.
class Beam {
	
	var startNode, endNode: Node?
	/// Flag for the need for iteration
	var isIterable: Bool
	
	/// Returns a Beam based on given start and end Nodes and isIterable property.
	///
	/// - Parameters:
	///   - startNode: Start Node of the Beam.
	///   - endNode: End Node of the Beam.
	///   - isIterable: Flag for the need for iteration.
	init(startNode: Node, endNode: Node, isIterable: Bool = true) {
		self.startNode = startNode
		self.endNode = endNode
		self.isIterable = isIterable
	}
	
}
