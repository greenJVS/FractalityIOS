//
//  Fractal.swift
//  FractalCore
//
//  Created by Admin on 28/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

public class Fractal {
	
	var nodes: [Node]
	var beams: [Beam]
	
	var axiomBeam: Beam? = nil
	var iterationRule: IterationRule? = nil
	
	/// Returns a Fractal.
	init() {
		self.nodes = []
		self.beams = []
	}
	
	/// Returns a zero-iteration Fractal based on given Axiom Beam and Iteration Rule.
	///
	/// - Parameters:
	///   - axiom: Axiom Beam.
	///   - rule: Iteration Rule.
	init(axiom: Beam, rule: IterationRule) {
		self.axiomBeam = axiom
		self.iterationRule = rule
		
		self.nodes = []
		self.beams = []
		
		initialize()
	}
	
	/// Reset computed data and restore initial state of Fractal.
	func initialize() {
		self.nodes = []
		self.beams = []
		
		if let axiom = axiomBeam,
			let startNode = axiom.startNode,
			let endNode = axiom.endNode {
			save(node: startNode)
			save(node: endNode)
			save(beam: axiom)
		}
	}
	
	/// Add node to nodes array and get right number.
	///
	/// - Parameter node: Node to adding.
	func save(node: Node) {
		node.number = nodes.count + 1
		nodes.append(node)
	}
	
	/// Add Beam to Fractal.
	///
	/// - Parameter beam: Beam to adding.
	func save(beam: Beam) {
		beams.append(beam)
	}
	
	/// Recursively iterates a fractal to a specified iteration.
	///
	/// - Parameter iteration: Target iteration.
	func iterate(to iteration: Int) {
		guard iteration > 0 else { return }
		guard let iterationRule = iterationRule else { return }
		
		var newBeams: [Beam] = []
		let globalCoordinateSystem = CoordinateSystem()
		
		for beam in beams {
			if beam.isIterable {
				guard let startNode = beam.startNode, let endNode = beam.endNode else { return }
				
				let beamVector = Vector(fromPoint: startNode.point, to: endNode.point)
				let beamLength = beamVector.length
				
				guard let normalizedVector = beamVector.normalized() else { return }
				
				// Array of new nodes with added two nodes of current beam.
				var newNodes: [Node] = [startNode, endNode]
				
				// Basises of local Coordinate System
				let f1 = Vector(x: normalizedVector.x, y: normalizedVector.y, z: normalizedVector.z)
				let f2 = f1.orthogonalVector()
				guard let f3 = f1.producted(with: f2).normalized() else { return }
				
				// Origin of Coordinates System relative Global CS
				let relativeOrigin = startNode.point
				
				let localCoordinateSystem = CoordinateSystem(origin: relativeOrigin,
															 basis1: f1,
															 basis2: f2,
															 basis3: f3)
				
				guard let mCInv = localCoordinateSystem
					.transitionMatrix(to: globalCoordinateSystem)?
					.inversed() else { return }
				
				for var relativeVector in iterationRule.relativeVectors {
					relativeVector.multiply(by: beamLength)
					
					// 1 column Matrix of coordinates of rule's point
					var mCurrentPoint = Matrix2D(rows: 3, columns: 1)
					mCurrentPoint![0][0] = relativeVector.x
					mCurrentPoint![1][0] = relativeVector.y
					mCurrentPoint![2][0] = relativeVector.z
					
					// Product matrix of current point with inversed transition matrix
					// Result is 1 column matrix, where rows - is coordinates in new coordinate system
					guard let mNewNode = mCInv.producted(with: mCurrentPoint!) else { return }
					let newPoint = Point(x: mNewNode[0][0], y: mNewNode[1][0], z: mNewNode[2][0])
					
					// Create new node, shifted to beam's start.
					let newNode = Node(point: newPoint).shifted(by: relativeOrigin)
					save(node: newNode)
					newNodes.append(newNode)
				}
				
				for beam in iterationRule.beams {
					let startNodeIndex = beam.startNode - 1
					let endNodeIndex = beam.endNode - 1
					let isIterable = beam.isIterable
					
					let newBeam = Beam(
						startNode: newNodes[startNodeIndex],
						endNode: newNodes[endNodeIndex],
						isIterable: isIterable)
					newBeams.append(newBeam)
				}
			} else {
				newBeams.append(beam)
			}
		}
		
		beams = newBeams
		
		iterate(to: iteration - 1)
	}
}
