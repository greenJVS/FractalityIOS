//
//  IterationRule.swift
//  FractalCore
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

class IterationRule {
	
	/// Relative vectors to new nodes in local coordinate system.
	let relativeVectors: [Vector]
	
	/// Two dimensional array of info about beams.
	///
	/// Row has three elements. Structure:
	///
	/// First subscript - beam.
	///
	/// Second subscript - indices of node and iterable. Nodes with indices 0 and 1 it's start and end node of beam accordingly.
	///
	/// If third element equal 1, then beam is iterable.
	let beams: [[Int]]

	/// Returns a Iteration Rule based on give Relative Vectors and Beams.
	///
	/// - Parameters:
	///   - relativeVectors: Relative Vectors.
	///   - beams: Two dimensional array of info about beams.
	init?(relativeVectors: [Vector], beams: [[Int]]) {
		for beam in beams {
			if beam.count != 3 { return nil }
		}
		self.relativeVectors = relativeVectors
		self.beams = beams
	}
}
