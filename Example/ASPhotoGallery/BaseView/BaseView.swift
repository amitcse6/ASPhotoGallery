//
//  BaseView.swift
//  ASPhotoGallery_Example
//
//  Created by AMIT on 2/12/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    @IBOutlet var view: UIView!
    
    func commonInit() {
        view = loadViewFromNib(nibName: String(describing: Self.self))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

