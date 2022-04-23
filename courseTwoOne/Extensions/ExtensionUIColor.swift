//
//  ExtensionUIColor.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 13.04.22.
//

import UIKit

extension UIColor {
    static let castomColorVK = UIColor(red: 111.0 / 255.0, green: 1.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
}

extension UIColor {
    private static var colorCache: [String: UIColor] = [:]

    public static func colorInCaches(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        let key = "\(r)\(g)\(b)\(a)"

        if let color = colorCache[key] {
            return color
        }

        let color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
        colorCache[key] = color
        return color
    }
}
