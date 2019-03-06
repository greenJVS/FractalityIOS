//
//  NodeCollectionViewFlowLayout.swift
//  Fractality
//
//  Created by Admin on 02/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

class NodeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	private let minimunAspectRatio: CGFloat = 1.5
	private let itemHeight: CGFloat = 100
	
	private var viewWidth: CGFloat {
		let contentInsets = collectionView?.contentInset ?? .zero
		return (collectionView?.frame.width ?? 0.0) - contentInsets.left - contentInsets.right
	}
	
	var numberOfItemsInRow: Int {
		let numberOfItemsInRow: CGFloat = viewWidth / (itemHeight * minimunAspectRatio)
		return Int(numberOfItemsInRow)
	}
	
	override var minimumLineSpacing: CGFloat {
		get {
			return 0
		}
		set {
			self.minimumLineSpacing = newValue
		}
	}
	
	override var minimumInteritemSpacing: CGFloat {
		get {
			return 0
		}
		set {
			self.minimumInteritemSpacing = newValue
		}
	}
	
	override var itemSize: CGSize {
		get {
			let width = viewWidth / CGFloat(numberOfItemsInRow)
			return CGSize(width: width, height: itemHeight)
		}
		set {
			self.itemSize = newValue
		}
	}
	
}
