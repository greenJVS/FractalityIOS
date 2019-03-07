//
//  NodeCollectionViewCell.swift
//  Fractality
//
//  Created by Admin on 01/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

protocol NodeCollectionViewCellDelegate: class {
	func nodeCollectionViewCellDidTappedDelete(_ cell: NodeCollectionViewCell)
}

protocol MovableItem: class {
	var isMoving: Bool { get set }
}

class NodeCollectionViewCell: UICollectionViewCell, MovableItem {
	
	weak var delegate: NodeCollectionViewCellDelegate?
	
	private let inset: CGFloat = 10
	private let btnDeleteSize: CGFloat = 20
	
	private lazy var vCell: UIView = {
		let v = UIView()
		v.backgroundColor = .veryDarkGray
		v.layer.cornerRadius = 20
		
		/*
		v.layer.shadowColor = UIColor.black.cgColor
		v.layer.shadowRadius = 2
		v.layer.shadowOffset = CGSize(width: 0, height: 4)
		v.layer.shadowOpacity = 0.1
		*/
		
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var vCellPlaceholderEffect: UIVisualEffectView = {
		let effect = UIBlurEffect(style: .light)
		let v = UIVisualEffectView(effect: effect)
		v.layer.cornerRadius = 20
		v.layer.masksToBounds = true
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var vBtnDeleteEffect: UIVisualEffectView = {
		let effect = UIBlurEffect(style: .extraLight)
		let v = UIVisualEffectView(effect: effect)
		
		v.layer.cornerRadius = btnDeleteSize * 0.5
		v.layer.masksToBounds = true
		
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var btnDelete: UIButton = {
		let btn = UIButton(type: .system)
		btn.setTitle("✕", for: .normal)
		btn.addTarget(self, action: #selector(btnDelete_Tapped(_:)), for: .touchUpInside)
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
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
	
	//	private func updateArrows() {
	//		arrows.enumerated().forEach({ index, view in
	//			view.isHidden = !(arrowsDirections.count > index)
	//			if isSelected {
	//				alignRotationToCenter(view: view, at: index)
	//
	//				if arrowsDirections.count > index, !arrowsDirections[index] {
	//					view.transform = view.transform.rotated(by: .pi)
	//				}
	//			}
	//		})
	//	}
	
	private var arrows: [Arrow] = []
	var arrowsState: ([Orientation], [Direction]) = ([], []) {
		didSet {
//			arrows.update()
			
			let orientations = arrowsState.0
			let directions = arrowsState.1
			
			if isSelected {
				print("Node \(lblNumber.text!) \t\t max:\(directions.count) \t\t need: \(orientations.count)")
			}
			
			var shownArrowCount = 0
			arrows.forEach({ arrow in
				
				guard orientations.count > shownArrowCount, isSelected else {
					arrow.isHidden = true
					return
				}
				
				let isValidDirection = directions.contains(arrow.direction)
				arrow.isHidden = !isValidDirection
				
				if isValidDirection {
					arrow.orientation = orientations[shownArrowCount]
					arrow.type = .rule
					
					shownArrowCount += 1
					arrow.update()
				}
				
			})
		}
	}
	var isEditing: Bool = false {
		didSet {
			vBtnDeleteEffect.isHidden = !isEditing
		}
	}
	var isPlaceholder: Bool = false {
		didSet {
			vCellPlaceholderEffect.isHidden = !isPlaceholder
		}
	}
	
	var isMoving: Bool = false {
		didSet {
			UIView.animate(
				withDuration: isMoving ? 0.1 : 0.25,
				delay: 0,
				options: isMoving ? .curveEaseIn : .curveEaseOut,
				animations: {
					self.vBtnDeleteEffect.alpha = self.isMoving ? 0 : 1
					self.vCell.alpha = self.isMoving ? 0.75 : 1
					self.vCell.transform = self.isMoving ? .init(scaleX: 1.1, y: 1.1) : .identity
			},
				completion: nil)
		}
	}
	
//	override var isSelected: Bool {
//		didSet {
//			updateArrows()
//		}
//	}
	
	// https://stackoverflow.com/questions/40116282/preventing-moving-uicollectionviewcell-by-its-center-when-dragging
	override var isHighlighted: Bool {
		didSet {
			if isEditing {
				UIView.animate(withDuration: 0.05) {
					self.contentView.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
				}
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(vCell)
		contentView.addSubview(vBtnDeleteEffect)
		
		vCell.addSubview(lblNumber)
		vCell.addSubview(stvCoords)
		vCell.addSubview(vCellPlaceholderEffect)
		
		stvCoords.addArrangedSubview(lblCoordX)
		stvCoords.addArrangedSubview(lblCoordY)
		stvCoords.addArrangedSubview(lblCoordZ)
		
		vBtnDeleteEffect.contentView.addSubview(btnDelete)
		
		let btnDeletePadding: CGFloat = 0
		
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
			stvCoords.bottomAnchor.constraint(equalTo: vCell.bottomAnchor, constant: -16),
			
			vCellPlaceholderEffect.leadingAnchor.constraint(equalTo: vCell.leadingAnchor, constant: 0),
			vCellPlaceholderEffect.trailingAnchor.constraint(equalTo: vCell.trailingAnchor, constant: 0),
			vCellPlaceholderEffect.topAnchor.constraint(equalTo: vCell.topAnchor, constant: 0),
			vCellPlaceholderEffect.bottomAnchor.constraint(equalTo: vCell.bottomAnchor, constant: 0),
			
			vBtnDeleteEffect.centerYAnchor.constraint(equalTo: vCell.topAnchor, constant: 2),
			vBtnDeleteEffect.centerXAnchor.constraint(equalTo: vCell.leadingAnchor, constant: 2),
			vBtnDeleteEffect.widthAnchor.constraint(equalToConstant: btnDeleteSize),
			vBtnDeleteEffect.heightAnchor.constraint(equalToConstant: btnDeleteSize),
			
			btnDelete.leadingAnchor.constraint(equalTo: vBtnDeleteEffect.leadingAnchor, constant: btnDeletePadding),
			btnDelete.trailingAnchor.constraint(equalTo: vBtnDeleteEffect.trailingAnchor, constant: -btnDeletePadding),
			btnDelete.topAnchor.constraint(equalTo: vBtnDeleteEffect.topAnchor, constant: btnDeletePadding),
			btnDelete.bottomAnchor.constraint(equalTo: vBtnDeleteEffect.bottomAnchor, constant: -btnDeletePadding)
		])
		
		contentView.bringSubviewToFront(vBtnDeleteEffect)
		
		addArrows()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
	
	private func addArrows() {
		func horizontalConstraint(for view: UIView, with direction: Direction) -> NSLayoutConstraint {
			switch direction {
			case .northwest, .west, .southwest:
				return view.centerXAnchor.constraint(equalTo: contentView.leadingAnchor)
			case .north, .south:
				return view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
			case .northeast, .east, .southeast:
				return view.centerXAnchor.constraint(equalTo: contentView.trailingAnchor)
			}
		}
		
		func verticalConstraint(for view: UIView, with direction: Direction) -> NSLayoutConstraint {
			switch direction {
			case .northwest, .north, .northeast:
				return view.centerYAnchor.constraint(equalTo: contentView.topAnchor)
			case .west, .east:
				return view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			case .southwest, .south, .southeast:
				return view.centerYAnchor.constraint(equalTo: contentView.bottomAnchor)
			}
		}
		
		arrows.forEach({ $0.removeFromSuperview() })
		arrows = []
		
		let arrowWidth = inset * 1.7
		
		Direction.allCases.forEach({
			let arrow = Arrow(direction: $0, width: arrowWidth)
			arrow.isHidden = true
			arrows.append(arrow)
			contentView.addSubview(arrow)

			NSLayoutConstraint.activate([
				horizontalConstraint(for: arrow, with: $0),
				verticalConstraint(for: arrow, with: $0)
				])
		})
	}
	
	@objc private func btnDelete_Tapped(_ sender: UIButton) {
		delegate?.nodeCollectionViewCellDidTappedDelete(self)
	}
}
