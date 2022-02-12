//
//  BannerView.swift
//  ASPhotoGallery_Example
//
//  Created by AMIT on 2/12/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

protocol BannerViewDelegate: AnyObject {
    func bannerReadMoreEvent(_ view: BannerView)
}

@IBDesignable
class BannerView: BaseView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerBack: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prologueLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var readMoreLabel: UILabel!
    
    weak var delegate: BannerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func commonInit() {
        super.commonInit()
    }
}
