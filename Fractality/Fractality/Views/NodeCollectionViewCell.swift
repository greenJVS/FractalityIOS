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
		v.clipsToBounds = true
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()
	private lazy var lblNumber: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .softYellow
		lbl.font = .systemFont(ofSize: 48, weight: .regular)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	private lazy var stvCoords: UIStackView = {
		let stv = UIStackView()
		stv.axis = .vertical
		stv.distribution = .equalSpacing
		stv.translatesAutoresizingMaskIntoConstraints = false
		return stv
	}()
	private lazy var lblCoordX: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .softRed
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	private lazy var lblCoordY: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .limeGreen
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	private lazy var lblCoordZ: UILabel = {
		let lbl = UILabel()
		lbl.textColor = .brightBlue
		lbl.font = .systemFont(ofSize: 12, weight: .regular)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.addSubview(vCell)
		
		vCell.addSubview(lblNumber)
		vCell.addSubview(stvCoords)
		
		stvCoords.addArrangedSubview(lblCoordX)
		stvCoords.addArrangedSubview(lblCoordY)
		stvCoords.addArrangedSubview(lblCoordZ)
		
		
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
	
	private func createUI() {
		
	}
	
}
