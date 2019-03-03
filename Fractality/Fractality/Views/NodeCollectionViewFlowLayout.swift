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
			let height: CGFloat = 100
			let viewWidth = collectionView?.frame.width ?? 0.0
			let numberOfItemsInRow: CGFloat = viewWidth / (height * minimunAspectRatio)
			let width = viewWidth / numberOfItemsInRow.rounded(.down)
			
			return CGSize(width: width, height: height)
		}
		set {
			self.itemSize = newValue
		}
	}
	
}
