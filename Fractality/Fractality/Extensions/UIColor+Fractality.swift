//
//  UIColor+Fractality.swift
//  Fractality
//
//  Created by Admin on 01/03/2019.
//  Copyright © 2019 GreenJVS. All rights reserved.
//

import UIKit

extension UIColor {
	static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) -> UIColor {
		let devider: CGFloat = 255
		return UIColor(red: r/devider, green: g/devider, blue: b/devider, alpha: a/devider)
	}
	
	open class var softYellow: UIColor { return UIColor.rgba(r: 242, g: 201, b: 76) }
	open class var softRed: UIColor { return UIColor.rgba(r: 235, g: 87, b: 87) }
	open class var limeGreen: UIColor { return UIColor.rgba(r: 39, g: 174, b: 96) }
	open class var brightBlue: UIColor { return UIColor.rgba(r: 45, g: 156, b: 219) }
	open class var veryDarkGray: UIColor { return UIColor.rgba(r: 36, g: 35, b: 35) }
	open class var graphite: UIColor { return UIColor.rgba(r: 51, g: 51, b: 51) }
}
