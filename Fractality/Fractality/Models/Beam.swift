//
//  Beam.swift
//  Fractality
//
//  Created by Admin on 04/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import Foundation

class Beam {
	var number: Int
	var startNode: Node?
	var endNode: Node?
	
	init(number: Int, from startNode: Node?, to endNode: Node?) {
		self.number = number
		self.startNode = startNode
		self.endNode = endNode
	}
}
