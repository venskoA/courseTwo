//
//  View.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 20.02.22.
//

import UIKit

extension UIView {
    convenience init(tran: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = tran
    }
}
