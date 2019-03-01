//
//  NodeCollectionViewFlowLayout.swift
//  Fractality
//
//  Created by Admin on 02/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

class NodeCollectionViewFlowLayout: UICollectionViewFlowLayout {
	
	override var itemSize: CGSize {
		get {
			return CGSize(width: 130, height: 100)
		}
		set {
			self.itemSize = newValue
		}
	}
	
}
