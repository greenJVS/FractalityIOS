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
	private var movingItemOffset: CGPoint = .zero
	private var movingIndexPath: IndexPath? {
		didSet {
			if let indexPath = movingIndexPath {
				(collectionView.cellForItem(at: indexPath) as? MovableItem)?.isMoving = true
			} else if let indexPath = oldValue {
				(collectionView.cellForItem(at: indexPath) as? MovableItem)?.isMoving = false
			}
		}
	}
	
	private var nodes: [Node] = []
	private var relativeNodes: [(node: Node, isStart: Bool)] = []
	private var beams: [Beam] = []
	
	private lazy var barBtnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barBtnAdd_Tapped(_:)))
	
	private var gestureRecognizer: UILongPressGestureRecognizer!
	
	init() {
		super.init(collectionViewLayout: flowLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Fractality"
		
		NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
		
		gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognizerTriggered(recognizer:)))
		gestureRecognizer.minimumPressDuration = 0.49
		self.collectionView.addGestureRecognizer(gestureRecognizer)
		
		self.navigationItem.leftBarButtonItem = editButtonItem
		self.navigationItem.rightBarButtonItem = barBtnAdd
		
		self.collectionView.backgroundColor = .graphite
		self.collectionView.allowsSelection = true
		self.collectionView.allowsMultipleSelection = false
		self.collectionView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
		
		self.clearsSelectionOnViewWillAppear = false
		
		// Register cell classes
		self.collectionView.register(NodeCollectionViewCell.self, forCellWithReuseIdentifier: kNodeCVCellReuseIdentifier)
		
		#warning("Remove test data")
		(0..<10).forEach({ _ in
			let x = Double.random(in: -10..<10)
			let y = Double.random(in: -10..<10)
			let z = Double.random(in: -10..<10)
			let node = Node(number: nodes.count, x: x, y: y, z: z)
			nodes.append(node)
		})
		beams.append(Beam(number: 0,
						  from: nodes.first(where: { $0.number == 0 }),
						  to: nodes.first(where: { $0.number == 1 })))
		beams.append(Beam(number: 1,
						  from: nodes.first(where: { $0.number == 0 }),
						  to: nodes.first(where: { $0.number == 2 })))
		beams.append(Beam(number: 2,
						  from: nodes.first(where: { $0.number == 0 }),
						  to: nodes.first(where: { $0.number == 3 })))
		beams.append(Beam(number: 3,
						  from: nodes.first(where: { $0.number == 0 }),
						  to: nodes.first(where: { $0.number == 4 })))
		beams.append(Beam(number: 4,
						  from: nodes.first(where: { $0.number == 5 }),
						  to: nodes.first(where: { $0.number == 1 })))
		beams.append(Beam(number: 5,
						  from: nodes.first(where: { $0.number == 5 }),
						  to: nodes.first(where: { $0.number == 2 })))
		beams.append(Beam(number: 6,
						  from: nodes.first(where: { $0.number == 5 }),
						  to: nodes.first(where: { $0.number == 3 })))
		beams.append(Beam(number: 7,
						  from: nodes.first(where: { $0.number == 5 }),
						  to: nodes.first(where: { $0.number == 4 })))
		beams.append(Beam(number: 8,
						  from: nodes.first(where: { $0.number == 7 }),
						  to: nodes.first(where: { $0.number == 5 })))
	}

	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		
		barBtnAdd.isEnabled = !editing
		
		if !editing {
			nodes.enumerated().forEach({ index, node in
				nodes[index].number = index
			})
		} else {
			selectedIndexPath = nil
		}
		
		collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
	}
	
	private func updateRelativeNodes(for node: Node) {
		relativeNodes = []
		beams.forEach({
			guard let startNode = $0.startNode, let endNode = $0.endNode else { return }
			if startNode.number == node.number {
				relativeNodes.append((node: endNode, isStart: true))
			} else if endNode.number == node.number {
				relativeNodes.append((node: startNode, isStart: false))
			}
		})
	}
	
	private func offsetOfTouchFrom(recognizer: UIGestureRecognizer, inCell cell: UICollectionViewCell) -> CGPoint {
		
		let locationOfTouchInCell = recognizer.location(in: cell)
		
		let cellCenterX = cell.frame.width / 2
		let cellCenterY = cell.frame.height / 2
		
		let cellCenter = CGPoint(x: cellCenterX, y: cellCenterY)
		
		var offSetPoint = CGPoint.zero
		
		offSetPoint.y = cellCenter.y - locationOfTouchInCell.y
		offSetPoint.x = cellCenter.x - locationOfTouchInCell.x
		
		return offSetPoint
		
	}
	
	@objc private func gestureRecognizerTriggered(recognizer: UILongPressGestureRecognizer) {
		guard isEditing else { return }
		
		switch(recognizer.state) {
		case .began:
			guard let indexPath = collectionView.indexPathForItem(at: recognizer.location(in: self.collectionView)),
				let cell = collectionView.cellForItem(at: indexPath) else { return }
			
			collectionView.beginInteractiveMovementForItem(at: indexPath)
			movingIndexPath = indexPath
			
			movingItemOffset = offsetOfTouchFrom(recognizer: recognizer, inCell: cell)
			
			// This is the vanilla location of the touch that alone would make the cell's center snap to user touch location
			var location = recognizer.location(in: collectionView)
			
			location.x += movingItemOffset.x
			location.y += movingItemOffset.y
			
			collectionView.updateInteractiveMovementTargetPosition(location)
		case .changed:
			var location = recognizer.location(in: collectionView)
			
			location.x += movingItemOffset.x
			location.y += movingItemOffset.y
			
			collectionView.updateInteractiveMovementTargetPosition(location)
		case .ended:
			movingIndexPath = nil
			collectionView.endInteractiveMovement()
		default:
			movingIndexPath = nil
			collectionView.cancelInteractiveMovement()
		}
	}
	
	@objc private func barBtnAdd_Tapped(_ sender: UIBarButtonItem) {
		let x = Double.random(in: -10..<10)
		let y = Double.random(in: -10..<10)
		let z = Double.random(in: -10..<10)
		let node = Node(number: nodes.count, x: x, y: y, z: z)
		nodes.append(node)
		
		let indexPath = IndexPath(item: nodes.count - 1, section: 0)
		collectionView.insertItems(at: [indexPath])
	}
	
	@objc func orientationChanged(_ notification: NSNotification) {
		gestureRecognizer.state = .possible
		collectionView.endInteractiveMovement()
		movingIndexPath = nil
		print("WTF! gesture state \(gestureRecognizer.state.rawValue)")
		collectionView.reloadData()
	}
	
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nodes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNodeCVCellReuseIdentifier, for: indexPath) as? NodeCollectionViewCell {
			let node = nodes[indexPath.row]
			cell.fill(node: node)
			
			cell.isEditing = self.isEditing
			let isSelected = selectedIndexPath == indexPath && !isEditing
			cell.arrowsDirections = isSelected ? relativeNodes.map({ $0.1 }) : []
			cell.isSelected = isSelected
			
			// Логика для определения отображения ячейки, как плейсхолдера
			let isContainsInRelative = relativeNodes.contains(where: { $0.node.number == node.number })
			let canBePlaceholder = !self.isEditing && selectedIndexPath != nil
			
			let isPlaceholder: Bool = {
				if canBePlaceholder {
					if isContainsInRelative || selectedIndexPath == indexPath {
						return false
					}
					return true
				}
				return false
			}()
			
			cell.isPlaceholder = isPlaceholder
			
			cell.delegate = self
			return cell
		}
		
        return UICollectionViewCell()
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if selectedIndexPath == indexPath {
			collectionView.deselectItem(at: indexPath, animated: true)
			selectedIndexPath = nil
			barBtnAdd.isEnabled = true
			
			relativeNodes = []
		} else {
			selectedIndexPath = indexPath
			barBtnAdd.isEnabled = false
			let node = nodes[indexPath.item]
			
			updateRelativeNodes(for: node)
		}
		
		collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
	}
	
    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
	
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !isEditing
    }
	
	override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		print("can move called!")
		return isEditing
	}
	
	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let item = nodes.remove(at: sourceIndexPath.item)
		nodes.insert(item, at: destinationIndexPath.item)
	}
	
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
	/*
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
	
	
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
		print("wtf")
    }
	*/

}

// MARK: - NodeCollectionViewCellDelegate

extension NodesCollectionViewController: NodeCollectionViewCellDelegate {
	
	func nodeCollectionViewCellDidTappedDelete(_ cell: NodeCollectionViewCell) {
		if let indexPath = collectionView.indexPath(for: cell) {
			nodes.remove(at: indexPath.item)
			collectionView.deleteItems(at: [indexPath])
		}
	}
	
}
