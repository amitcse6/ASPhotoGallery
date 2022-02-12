//
//  ASPageView.swift
//  Gonzo
//
//  Created by AMIT on 2/3/22.
//

import Foundation
import UIKit

class ASPPageView: UIView {
    var containerView: UIView!
    var pageControl: UIPageControl!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    func initialization() {
        layer.masksToBounds = true
        loadContainerView()
        loadPager()
    }
    
    func loadContainerView() {
        containerView = UIView()
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func loadPager() {
        pageControl = UIPageControl()
        containerView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        pageControl.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        pageControl.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
}
