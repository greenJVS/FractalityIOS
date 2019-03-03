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

class NodeCollectionViewCell: UICollectionViewCell {
	
	weak var delegate: NodeCollectionViewCellDelegate?
	
	private let inset: CGFloat = 10
	private let btnDeleteSize: CGFloat = 20
	
	private lazy var vCell: UIView = {
		let v = UIView()
		v.backgroundColor = .veryDarkGray
		v.layer.cornerRadius = 20
		
		v.layer.shadowColor = UIColor.black.cgColor
		v.layer.shadowRadius = 2
		v.layer.shadowOffset = CGSize(width: 0, height: 4)
		v.layer.shadowOpacity = 0.1
		v.layer.masksToBounds = true
		
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var vCellPlaceholderEffect: UIVisualEffectView = {
		let effect = UIBlurEffect(style: .light)
		let v = UIVisualEffectView(effect: effect)
		
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
	
	private var arrows: [UIView] = []
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
	
	override var isSelected: Bool {
		didSet {
			updateArrows()
		}
	}
	
	override var isHighlighted: Bool {
		didSet {
			if isEditing {
//				vCellPlaceholderEffect.isHidden = !isHighlighted
				UIView.animate(withDuration: 0.15) {
					self.contentView.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
				}
			}
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
		let angle: CGFloat = {
			switch index {
			case 0: return .pi * 1.5
			case 1: return .pi * 0.5
			case 2: return .pi
			case 3: return 0
			case 4: return .pi * 1.25
			case 5: return .pi * 1.75
			case 6: return .pi * 0.75
			case 7: return .pi * 0.25
			default: return 0
			}
		}()
		view.transform = CGAffineTransform(rotationAngle: angle)
	}
	
	private func addArrows() {
		func horizontalConstraint(for view: UIView, at index: Int) -> NSLayoutConstraint {
			switch index {
			case 4, 2, 6:
				return view.centerXAnchor.constraint(equalTo: contentView.leadingAnchor)
			case 0, 1:
				return view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
			case 5, 3, 7:
				return view.centerXAnchor.constraint(equalTo: contentView.trailingAnchor)
			default:
				return NSLayoutConstraint()
			}
		}
		
		func verticalConstraint(for view: UIView, at index: Int) -> NSLayoutConstraint {
			switch index {
			case 4, 0, 5:
				return view.centerYAnchor.constraint(equalTo: contentView.topAnchor)
			case 2, 3:
				return view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
			case 6, 1, 7:
				return view.centerYAnchor.constraint(equalTo: contentView.bottomAnchor)
			default:
				return NSLayoutConstraint()
			}
		}
		
		arrows.forEach({ $0.removeFromSuperview() })
		arrows = []
		
		let image = #imageLiteral(resourceName: "arrow")
		let aspectRatio = image.size.width / image.size.height
		
		let arrowWidth = inset * 1.7
		let size = CGSize(width: arrowWidth, height: arrowWidth / aspectRatio)
		
		(0..<8).forEach({
			let imgArrow = UIImageView(image: image)
			imgArrow.isHidden = true
			imgArrow.translatesAutoresizingMaskIntoConstraints = false
			imgArrow.tintColor = .red
			
			arrows.append(imgArrow)
			contentView.addSubview(imgArrow)
			
			NSLayoutConstraint.activate([
				imgArrow.widthAnchor.constraint(equalToConstant: size.width),
				imgArrow.heightAnchor.constraint(equalToConstant: size.height),
				
				horizontalConstraint(for: imgArrow, at: $0),
				verticalConstraint(for: imgArrow, at: $0)
				])
		})
	}
	
	@objc private func btnDelete_Tapped(_ sender: UIButton) {
		delegate?.nodeCollectionViewCellDidTappedDelete(self)
	}
}
