//
//  ASPhotoGallery+Extension.swift
//  Gonzo
//
//  Created by AMIT on 2/3/22.
//

import Foundation
import UIKit

public extension ASPhotoGallery {
    func initialization() {
        loadContainerView()
        loadScrollView()
        loadStackView()
        loadSubView()
        loadLeftArrow()
        loadRightArrow()
        loadPager()
    }
    
    func loadContainerView() {
        removeViewIfExists(containerView)
        containerView = UIView()
        addSubview(containerView)
        loadContainerViewConst()
    }
    
    func loadScrollView() {
        removeViewIfExists(scrollView)
        scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces=true
        scrollView.isScrollEnabled=true
        scrollView.bounces = true
        scrollView.bouncesZoom = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        containerView.addSubview(scrollView)
        loadScrollViewConst()
    }
    
    func loadStackView() {
        removeViewIfExists(stackView)
        stackView = UIStackView()
        scrollView.addSubview(stackView)
        loadStackViewConst()
    }
    
    func loadPager() {
        removeViewIfExists(pageView)
        pageView = ASPPageView()
        pageView.pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .touchUpInside)
        pageView.pageControl.numberOfPages = numberOfItems
        pageView.pageControl.currentPage = visibleIndex
        pageView.pageControl.tintColor = pageTintColor
        pageView.pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        pageView.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        containerView.addSubview(pageView)
        loadPagerConst()
    }
    
    func loadLeftArrow() {
        removeViewIfExists(leftArrow)
        if let leftArrowImage = leftArrowImage {
            leftArrow = UIImageView()
            leftArrow?.image = leftArrowImage
            leftArrow?.contentMode = .scaleAspectFill
            leftArrow?.isUserInteractionEnabled = true
            leftArrow?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftAnchorEvent)))
            containerView.addSubview(leftArrow!)
            leftArrowConst()
        }
    }
    
    func loadRightArrow() {
        removeViewIfExists(rightArrow)
        if let rightArrowImage = rightArrowImage {
            rightArrow = UIImageView()
            rightArrow?.image = rightArrowImage
            rightArrow?.contentMode = .scaleAspectFill
            rightArrow?.isUserInteractionEnabled = true
            rightArrow?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightAnchorEvent)))
            containerView.addSubview(rightArrow!)
            rightArrowConst()
        }
    }
    
    func loadSubView() {
        removeAllData()
        if let delegate = delegate {
            numberOfItems = delegate.asPhotoGalleryNumberOfItems(self)
            (0..<numberOfItems).enumerated().forEach { (index, _) in
                let backView = UIView()
                stackView.addArrangedSubview(backView)
                backView.translatesAutoresizingMaskIntoConstraints = false
                if let itemWidth = itemWidth {
                    backView.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
                }else {
                    backView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
                }
                backView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0).isActive = true
                backView.tag = index
                backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectItem)))
                
                let itemView = delegate.asPhotoGallery(self, itemAt: index)
                backView.addSubview(itemView)
                itemView.translatesAutoresizingMaskIntoConstraints = false
                itemView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0).isActive = true
                itemView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0).isActive = true
                itemView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0).isActive = true
                itemView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0).isActive = true
                views.append(backView)
            }
        }
    }
}

extension ASPhotoGallery {
    func loadContainerViewConst() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func loadScrollViewConst() {
        scrollView.backgroundColor = .green
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: containerPadding.height).isActive = true
        let leftAnchor = scrollView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor, constant: containerPadding.width)
        let rightAnchor = scrollView.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -containerPadding.width)
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -containerPadding.height-pagerHeight).isActive = true
        leftAnchor.priority = UILayoutPriority(1000)
        rightAnchor.priority = UILayoutPriority(1000)
        leftAnchor.isActive = true
        rightAnchor.isActive = true
    }
    
    func loadStackViewConst() {
        stackView.axis  = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing   = stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
    }
    
    func loadPagerConst() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        pageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        pageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        pageView.heightAnchor.constraint(equalToConstant: pagerHeight).isActive = true
    }
    
    func leftArrowConst() {
        leftArrow?.translatesAutoresizingMaskIntoConstraints = false
        leftArrow?.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        leftArrow?.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0).isActive = true
        leftArrow?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        leftArrow?.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func rightArrowConst() {
        rightArrow?.translatesAutoresizingMaskIntoConstraints = false
        rightArrow?.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true
        rightArrow?.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0).isActive = true
        rightArrow?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightArrow?.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

extension ASPhotoGallery {
    func removeAllData() {
        stackView.removeAllArrangedSubviews()
        views.removeAll()
        views = []
    }
    
    func removeViewIfExists(_ childView: UIView?) {
        var childView = childView
        if childView != nil {
            childView?.removeFromSuperview()
            childView = nil
        }
    }
}
