//
//  ASPhotoGallery.swift
//  Gonzo
//
//  Created by AMIT on 2/3/22.
//

import Foundation
import UIKit

public protocol ASPhotoGalleryDelegate: AnyObject {
    func asPhotoGalleryNumberOfItems(_ gallery: ASPhotoGallery) -> Int
    func asPhotoGallery(_ gallery: ASPhotoGallery, itemAt index: Int) -> UIView
    func asPhotoGallery(_ gallery: ASPhotoGallery, selected view: UIView, didSelectAt index: Int)
}

public class ASPhotoGallery: UIView {
    var containerView: UIView!
    var scrollView: UIScrollView!
    var hStackView: UIStackView!
    var pageView: ASPPageView!
    var isWebLoad: Bool!
    
    var leftArrowImage: UIImage?
    var rightArrowImage: UIImage?
    var leftArrow: UIImageView?
    var rightArrow: UIImageView?
    
    public var pageTintColor: UIColor = UIColor.red
    public var pageIndicatorTintColor: UIColor = UIColor.black
    public var currentPageIndicatorTintColor: UIColor = UIColor.green
    
    public var views: [UIView] = []
    public var numberOfItems: Int = 0
    public var containerPadding: CGSize = CGSize.zero
    public var itemWidth: CGFloat?
    public var visibleIndex: Int = 0
    public var imageCornerRadius: CGFloat = 0
    public var pagerHeight: CGFloat = 0
    public var stackViewSpacing: CGFloat = 0
    public var scaleAspectFit: ContentMode = .scaleAspectFill
    public var isCustomScroll = false
    public var arrowSize: CGSize = CGSize(width: 40, height: 40)
    public var arrowPadding: CGPoint = CGPoint(x: 8, y: 0)
    
    public weak var delegate: ASPhotoGalleryDelegate?
}

public extension ASPhotoGallery {
    func setCurrentPage(_ currentPage: Int) {
        pageView.pageControl.currentPage = currentPage
    }
    
    func reloadData() {
        initialization()
    }
    
    func setLeftImage(_ image: UIImage?) {
        leftArrowImage = image
    }
    
    func setRightImage(_ image: UIImage?) {
        rightArrowImage = image
    }
    
    @objc func pageControlSelectionAction(_ sender: UIPageControl) {
        print("pageIndex: \(sender.currentPage)")
        currentPage(sender.currentPage)
    }
    
    @objc func leftAnchorEvent(_ sender: UITapGestureRecognizer) {
        previousPage()
    }
    
    @objc func rightAnchorEvent(_ sender: UITapGestureRecognizer) {
        nextPage()
    }
    
    @objc func selectItem(_ sender: UITapGestureRecognizer) {
        delegate?.asPhotoGallery(self, selected: sender.view!, didSelectAt: sender.view!.tag)
    }
    
    func currentPage(_ pageIndex: Int) {
        //visibleIndex = pageIndex
        //frame.origin.x = frame.size.width * CGFloat(pageIndex)
        //self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func previousPage() {
        var frame: CGRect = self.scrollView.frame
        let width = (isCustomScroll ? (itemWidth ?? 0) : frame.size.width)
        let currentPage = self.scrollView.contentOffset.x / width
        var previousPage = currentPage - 1
        if previousPage < 0 {
            previousPage = CGFloat(numberOfItems-1)
        }
        visibleIndex = Int(previousPage)
        
        frame.origin.x = width * CGFloat(previousPage)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func nextPage() {
        var frame: CGRect = self.scrollView.frame
        let width = (isCustomScroll ? (itemWidth ?? 0) : frame.size.width)
        let currentPage = self.scrollView.contentOffset.x / width
        var nextPage = currentPage + 1
        if nextPage >= CGFloat(numberOfItems) {
            nextPage = 0
        }
        visibleIndex = Int(nextPage)
        frame.origin.x = width * CGFloat(nextPage)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    @objc func setPage() {
        var frame: CGRect = self.scrollView.frame
        let width = (isCustomScroll ? (itemWidth ?? 0) : frame.size.width)
        let currentPage = self.visibleIndex
        visibleIndex = Int(currentPage)
        frame.origin.x = width * CGFloat(currentPage)
        self.scrollView.scrollRectToVisible(frame, animated: true)
    }
}

extension ASPhotoGallery: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        visibleIndex = scrollView.aspScrollCurrentPage
        pageView.pageControl.currentPage = visibleIndex
    }
}
