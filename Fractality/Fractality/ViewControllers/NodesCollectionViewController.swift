//
//  NodesCollectionViewController.swift
//  Fractality
//
//  Created by Admin on 01/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit



class NodesCollectionViewController: UICollectionViewController {

	private let kNodeCVCellReuseIdentifier = "NodeCell"
	
	private let flowLayout = NodeCollectionViewFlowLayout()
	
	private var selectedIndexPath: IndexPath?
	private var nodes: [Node] = []
	
	init() {
		super.init(collectionViewLayout: flowLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Fractality"
		
		self.collectionView.backgroundColor = .graphite
		self.collectionView.allowsSelection = true
		self.collectionView.allowsMultipleSelection = false
		
		self.clearsSelectionOnViewWillAppear = false
		
		// Register cell classes
		self.collectionView!.register(NodeCollectionViewCell.self, forCellWithReuseIdentifier: kNodeCVCellReuseIdentifier)
		
		(0..<35).forEach({
			let x = Double.random(in: -10..<10)
			let y = Double.random(in: -10..<10)
			let z = Double.random(in: -10..<10)
			let node = Node(number: $0, x: x, y: y, z: z)
			nodes.append(node)
		})
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return nodes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNodeCVCellReuseIdentifier, for: indexPath) as? NodeCollectionViewCell {
			let node = nodes[indexPath.row]
			cell.fill(node: node)
			return cell
		}
		
        return UICollectionViewCell()
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if selectedIndexPath == indexPath {
			collectionView.deselectItem(at: indexPath, animated: true)
			selectedIndexPath = nil
		} else {
			selectedIndexPath = indexPath
		}
	}
	
    // MARK: UICollectionViewDelegate

	
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }


	
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
	
	override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		print("moved")
	}
	
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
	
	

}

/*
extension NodesCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height: CGFloat = 100
		
		let numberOfItemsInRow: CGFloat = 3
		let viewWidth = self.view.frame.width
		let width = viewWidth / numberOfItemsInRow
		
		return CGSize(width: width - 2, height: height)
	}
}
*/
