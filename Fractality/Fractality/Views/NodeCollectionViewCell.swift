//
//  NodeCollectionViewCell.swift
//  Fractality
//
//  Created by Admin on 01/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

class NodeCollectionViewCell: UICollectionViewCell {
	
	private let inset: CGFloat = 10
	
	private lazy var vCell: UIView = {
		let v = UIView()
		v.backgroundColor = .veryDarkGray
		v.layer.cornerRadius = 20
		
		v.layer.shadowColor = UIColor.black.cgColor
		v.layer.shadowRadius = 2
		v.layer.shadowOffset = CGSize(width: 0, height: 4)
		v.layer.shadowOpacity = 0.05
		
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var lblNumber: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .softYellow
		lbl.font = .systemFont(ofSize: 48, weight: .regular)
		lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private lazy var stvCoords: UIStackView = {
		let stv = UIStackView()
		stv.axis = .vertical
		stv.distribution = .equalSpacing
		stv.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		stv.translatesAutoresizingMaskIntoConstraints = false
		return stv
	}()
	private lazy var lblCoordX: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .softRed
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.textAlignment = .right
		lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	private lazy var lblCoordY: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .limeGreen
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.textAlignment = .right
		lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	private lazy var lblCoordZ: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .brightBlue
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.textAlignment = .right
		lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private var arrows: [UIView] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(vCell)
		
		vCell.addSubview(lblNumber)
		vCell.addSubview(stvCoords)
		
		stvCoords.addArrangedSubview(lblCoordX)
		stvCoords.addArrangedSubview(lblCoordY)
		stvCoords.addArrangedSubview(lblCoordZ)
		
		NSLayoutConstraint.activate([
			vCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
			vCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
			vCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
			vCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
			
			lblNumber.leadingAnchor.constraint(equalTo: vCell.leadingAnchor, constant: 16),
			lblNumber.centerYAnchor.constraint(equalTo: vCell.centerYAnchor),
			
			stvCoords.leadingAnchor.constraint(equalTo: lblNumber.trailingAnchor, constant: 4),
			stvCoords.trailingAnchor.constraint(equalTo: vCell.trailingAnchor, constant: -12),
			stvCoords.topAnchor.constraint(equalTo: vCell.topAnchor, constant: 16),
			stvCoords.bottomAnchor.constraint(equalTo: vCell.bottomAnchor, constant: -16)
		])
		
		addArrows()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var isSelected: Bool {
		didSet {
			updateArrows()
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		lblNumber.text = nil
		lblCoordX.text = nil
		lblCoordY.text = nil
		lblCoordZ.text = nil
	}
	
	public func fill(number: Int, x: Double, y: Double, z: Double) {
		lblNumber.text = "\(number)"
		lblCoordX.text = String(format: "%.3f", x)
		lblCoordY.text = String(format: "%.3f", y)
		lblCoordZ.text = String(format: "%.3f", z)
	}
	
	public func fill(node: Node) {
		fill(number: node.number, x: node.x, y: node.y, z: node.z)
	}
	
	private func updateArrows() {
		arrows.enumerated().forEach({ index, view in
			view.isHidden = !isSelected
			if isSelected {
				rotateToCenter(view: view, at: index)
			}
		})
	}
	
	private func rotateToCenter(view: UIView, at index: Int) {
		/*
		let center = CGPoint(x: contentView.bounds.width * 0.5, y: contentView.bounds.height * 0.5)
		let viewCenter = view.center
		
		let deltaX: CGFloat = viewCenter.x - center.x
		let deltaY: CGFloat = viewCenter.y - center.y
		
		let angle = atan(deltaY / deltaX)
		*/
		let angle: CGFloat = {
			switch index {
			case 0: return .pi * 1.25
			case 1: return .pi * 1.5
			case 2: return .pi * 1.75
			case 3: return .pi
			case 4: return 0
			case 5: return .pi * 0.75
			case 6: return .pi * 0.5
			case 7: return .pi * 0.25
			default: return 0
			}
		}()
		view.transform = CGAffineTransform(rotationAngle: angle)
	}
	
	private func addArrows() {
		func horizontalConstraint(for view: UIView, at index: Int) -> NSLayoutConstraint {
			switch index {
			case 0, 3, 5:
				return view.centerXAnchor.constraint(equalTo: contentView.leadingAnchor)
			case 1, 6:
				return view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
			case 2, 4, 7:
				return view.centerXAnchor.constraint(equalTo: contentView.trailingAnchor)
			default:
				return NSLayoutConstraint()
			}
		}
		
		func verticalConstraint(for view: UIView, at index: Int) -> NSLayoutConstraint {
			switch index {
			case 0, 1, 2:
				return view.centerYAnchor.constraint(equalTo: contentView.topAnchor)
			case 3, 4:
				return view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			case 5, 6, 7:
				return view.centerYAnchor.constraint(equalTo: contentView.bottomAnchor)
			default:
				return NSLayoutConstraint()
			}
		}
		
		let size = CGSize(width: inset * 1.6, height: 3)
		
		arrows.forEach({ $0.removeFromSuperview() })
		arrows = []
		
		(0..<8).forEach({
			let vArrow = UIView()
			vArrow.isHidden = true
			vArrow.backgroundColor = .gray
			vArrow.translatesAutoresizingMaskIntoConstraints = false
			
			arrows.append(vArrow)
			contentView.addSubview(vArrow)
			
			NSLayoutConstraint.activate([
				vArrow.widthAnchor.constraint(equalToConstant: size.width),
				vArrow.heightAnchor.constraint(equalToConstant: size.height),
				
				horizontalConstraint(for: vArrow, at: $0),
				verticalConstraint(for: vArrow, at: $0)
				])
			
			let vDirection = UIView()
			vDirection.backgroundColor = .red
			vDirection.translatesAutoresizingMaskIntoConstraints = false
			
			vArrow.addSubview(vDirection)
			
			NSLayoutConstraint.activate([
				vDirection.trailingAnchor.constraint(equalTo: vArrow.trailingAnchor),
				vDirection.centerYAnchor.constraint(equalTo: vArrow.centerYAnchor),
				vDirection.heightAnchor.constraint(equalToConstant: 10),
				vDirection.widthAnchor.constraint(equalToConstant: 3)
				])
		})
	}
}
