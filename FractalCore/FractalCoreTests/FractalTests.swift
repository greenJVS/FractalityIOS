//
//  FractalTests.swift
//  FractalCoreTests
//
//  Created by Admin on 29/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import XCTest

class FractalTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
}

// MARK: Initialization

extension FractalTests {
	
	func testFractal_Initialization_EmptyFractal() {
		let emptyFractal = Fractal()
		
		XCTAssertEqual(emptyFractal.beams.count, 0)
		XCTAssertEqual(emptyFractal.nodes.count, 0)
		XCTAssertNil(emptyFractal.axiomBeam)
		XCTAssertNil(emptyFractal.iterationRule)
	}
	
	func testFractal_Initialization_ZeroIterationFractal() {
		let node1 = Node(point: Point(x: 1, y: 2, z: 3))
		let node2 = Node(point: Point(x: 1, y: 2, z: 3))
		let beam = Beam(startNode: node1, endNode: node2)
		
		let vectors = [
			Vector(x: 1, y: 2, z: 3),
			Vector(x: 2, y: 2, z: 3),
			Vector(x: 3, y: 2, z: 3)
		]
		
		let ruleBeams = [
			[0, 2, 1],
			[1, 2, 1],
			[2, 3, 1],
			[3, 0, 1]
		]
		let iterationRule = IterationRule(relativeVectors: vectors, beams: ruleBeams)!
		
		let fractal = Fractal(axiom: beam, rule: iterationRule)
		
		XCTAssertNotNil(fractal.axiomBeam)
		XCTAssertNotNil(fractal.iterationRule)
		XCTAssertEqual(fractal.nodes.count, 2)
		XCTAssertEqual(fractal.beams.count, 1)
	}
	
}

extension FractalTests {
	
	func testFractal_Iterations_NotEnoughInputData() {
		let fractal = Fractal()
		fractal.iterate(to: 100)
		
		XCTAssertEqual(fractal.beams.count, 0)
		XCTAssertEqual(fractal.nodes.count, 0)
		XCTAssertNil(fractal.axiomBeam)
		XCTAssertNil(fractal.iterationRule)
	}
	
	func testFractal_Iterations_PropertySetDataWithoutInitialize() {
		let node1 = Node(point: Point(x: 1, y: 2, z: 3))
		let node2 = Node(point: Point(x: 1, y: 2, z: 3))
		let beam = Beam(startNode: node1, endNode: node2)
		
		let vectors = [
			Vector(x: 1, y: 2, z: 3),
			Vector(x: 2, y: 2, z: 3),
			Vector(x: 3, y: 2, z: 3)
		]
		
		let ruleBeams = [
			[0, 2, 1],
			[1, 2, 1],
			[2, 3, 1],
			[3, 0, 1]
		]
		let iterationRule = IterationRule(relativeVectors: vectors, beams: ruleBeams)!
		
		let fractal = Fractal()
		fractal.axiomBeam = beam
		fractal.iterationRule = iterationRule
		fractal.iterate(to: 10)
		
		XCTAssertNotNil(fractal.axiomBeam)
		XCTAssertNotNil(fractal.iterationRule)
		XCTAssertEqual(fractal.beams.count, 0)
		XCTAssertEqual(fractal.nodes.count, 0)
	}
	
	func testFractal_Iterations_PropertySetDataWithInitialize() {
		let node1 = Node(point: Point(x: 1, y: 2, z: 3))
		let node2 = Node(point: Point(x: 1, y: 2, z: 3))
		let beam = Beam(startNode: node1, endNode: node2)
		
		let vectors = [
			Vector(x: 1, y: 2, z: 3),
			Vector(x: 2, y: 2, z: 3),
			Vector(x: 3, y: 2, z: 3)
		]
		
		let ruleBeams = [
			[0, 2, 1],
			[1, 2, 1],
			[2, 3, 1],
			[3, 0, 1]
		]
		let iterationRule = IterationRule(relativeVectors: vectors, beams: ruleBeams)!
		
		let fractal = Fractal()
		fractal.axiomBeam = beam
		fractal.iterationRule = iterationRule
		fractal.initialize()
		
		XCTAssertNotNil(fractal.axiomBeam)
		XCTAssertNotNil(fractal.iterationRule)
		XCTAssertEqual(fractal.beams.count, 1)
		XCTAssertEqual(fractal.nodes.count, 2)
	}
	
}

// MARK: Iterations

extension FractalTests {
	
	func testFractal_Iterations_Test1() {
		// Два узла, опеределяющие начальный стержень. "Аксиома"
		let node1 = Node(point: Point(x: 0, y: 0, z: 0))
		let node2 = Node(point: Point(x: 1, y: 0, z: 0))
		// Узлы, определяющие "правило" итерирования
		let node3 = Node(point: Point(x: 0.333, y: 0, z: 0))
		let node4 = Node(point: Point(x: 0.5, y: 0.25, z: 0))
		let node5 = Node(point: Point(x: 0.666, y: 0, z: 0))
		
		let initalFractal = Fractal()
		initalFractal.save(node: node1)
		initalFractal.save(node: node2)
		
		initalFractal.save(node: node3)
		initalFractal.save(node: node4)
		initalFractal.save(node: node5)
		
		initalFractal.save(beam: Beam(startNode: node1, endNode: node3))
		initalFractal.save(beam: Beam(startNode: node3, endNode: node4))
		initalFractal.save(beam: Beam(startNode: node4, endNode: node5))
		initalFractal.save(beam: Beam(startNode: node5, endNode: node2))
		
		let vector = Vector(fromPoint: node1.point, to: node2.point)
		let length = vector.length
		
		var relativeVectors: [Vector] = []
		for i in 2..<initalFractal.nodes.count {
			let localNode = initalFractal.nodes[i].shifted(by: node1.point)
			let originNode = Node()
			var currentVector = Vector(fromPoint: originNode.point, to: localNode.point)
			currentVector.multiply(by: 1.0 / length)
			relativeVectors.append(currentVector)
		}
		
		var ruleBeams: [[Int]] = []
		for beam in initalFractal.beams {
			let startNodeNumber = beam.startNode!.number
			let endNodeNumber = beam.endNode!.number
			let isIterable = beam.isIterable ? 1 : 0
			
			let ruleBeam = [startNodeNumber, endNodeNumber, isIterable]
			ruleBeams.append(ruleBeam)
		}
		
		let iterationRule = IterationRule(relativeVectors: relativeVectors, beams: ruleBeams)!
		
		let fNodeStart = Node(point: Point(x: 0, y: 0, z: 0))
		let fNodeEnd = Node(point: Point(x: 1, y: 0, z: 0))
		let startBeam = Beam(startNode: fNodeStart, endNode: fNodeEnd)
		
		let fractal = Fractal(axiom: startBeam, rule: iterationRule)
		fractal.initialize()
		
		let iterations = 2
		
		fractal.iterate(to: iterations)
		
		XCTAssertEqual(fractal.beams.count, 16)
		
		print("=== Fractal Output! ===")
		print("\(fractal.nodes.count) nodes:")
		for node in fractal.nodes {
			let x = String(format: "%.3f", node.point.x)
			let y = String(format: "%.3f", node.point.y)
			let z = String(format: "%.3f", node.point.z)
			print("- \(node.number) \t\(x)\t\(y)\t\(z)")
		}
		print()
		print("\(fractal.beams.count) beams:")
		for beam in fractal.beams {
			print("- start: \(beam.startNode!.number)\tend: \(beam.endNode!.number)")
		}
		print("done.")
	}
	
}
