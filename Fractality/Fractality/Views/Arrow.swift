//
//  Direction.swift
//  Fractality
//
//  Created by Admin on 06/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

enum Direction: CaseIterable {
	case north, south, west, east
	case northwest, northeast, southwest, southeast
}

enum Orientation {
	case incoming
	case outcoming
	case both
}

enum ArrowType {
	case axiom, rule
}

protocol Updatable {
	func update()
}

class Arrow: UIImageView, Updatable {
	let direction: Direction
	
	var orientation: Orientation = .outcoming
	var type: ArrowType = .rule
	
	private var angle: CGFloat {
		switch direction {
		case .north: return .pi * 1.5
		case .south: return .pi * 0.5
		case .west: return .pi
		case .east: return 0
		case .northwest: return .pi * 1.25
		case .northeast: return .pi * 1.75
		case .southwest: return .pi * 0.75
		case .southeast: return .pi * 0.25
		}
	}
	private var width: CGFloat
	
	init(direction: Direction, width: CGFloat) {
		self.direction = direction
		self.width = width
		let image = #imageLiteral(resourceName: "arrow")
		super.init(image: image)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		guard let image = image else { return }
		let aspectRatio = image.size.width / image.size.height
		
//		NSLayoutConstraint.activate([
//			self.widthAnchor.constraint(equalToConstant: width),
//			self.heightAnchor.constraint(equalToConstant: width / aspectRatio),
//			])
	}
	
	func update() {
		let transform: CGAffineTransform = {
			switch orientation {
			case .incoming:
				return CGAffineTransform(rotationAngle: angle + .pi)
			case .outcoming:
				return CGAffineTransform(rotationAngle: angle)
			case .both:
				print("Node has both orientation!")
				return CGAffineTransform(rotationAngle: angle)
			}
		}()
		self.transform = transform
		
		let color: UIColor = {
			switch type {
			case .axiom: return .magenta
			case .rule: return .softYellow
			}
		}()
		self.tintColor = color
	}
}

extension Array where Element: Updatable {
	func update() {
		forEach({ $0.update() })
	}
}
