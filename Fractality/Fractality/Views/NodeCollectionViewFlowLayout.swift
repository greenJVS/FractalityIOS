//
//  NodeCollectionViewFlowLayout.swift
//  Fractality
//
//  Created by Admin on 02/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

class NodeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
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
			
			let numberOfItemsInRow: CGFloat = 3
			let viewWidth = collectionView?.frame.width ?? 0.0
			let width = viewWidth / numberOfItemsInRow
			
			return CGSize(width: width, height: height)
		}
		set {
			self.itemSize = newValue
		}
	}
	
}
