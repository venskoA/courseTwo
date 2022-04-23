//
//  StackView+.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 20.02.22.
//

import UIKit

extension UIStackView {
    convenience init(subview: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: subview)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
