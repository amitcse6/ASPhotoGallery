//
//  UIStackView+Extension.swift
//  ASPhotoGallery
//
//  Created by AMIT on 2/12/22.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach{ self.addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        for v in removedSubviews {
            if v.superview != nil {
                NSLayoutConstraint.deactivate(v.constraints)
                v.removeFromSuperview()
            }
        }
    }
}
