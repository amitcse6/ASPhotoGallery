//
//  UIScrollView+Extension.swift
//  Gonzo
//
//  Created by AMIT on 2/3/22.
//

import Foundation
import UIKit

extension UIScrollView {
    var asScrollCurrentPage: Int {
        Int(round(self.contentOffset.x / self.frame.width))
    }
}
