//
//  ViewController.swift
//  ASPhotoGallery
//
//  Created by Amit Mondol on 02/12/2022.
//  Copyright (c) 2022 Amit Mondol. All rights reserved.
//

import UIKit
import ASPhotoGallery

class ViewController: UIViewController {
    
    @IBOutlet weak var photoGallery: ASPhotoGalleryClassic!
    @IBOutlet weak var subPhotoGallery: ASPhotoGallery!
    @IBOutlet weak var subItemImageView: UIImageView!
    
    var items: [String] = []
    var subItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGallery(photoGallery)
        setupSubGallery(subPhotoGallery)
    }
    
    func setupGallery(_ photoGallery: ASPhotoGallery) {
        items = ["image0", "image1", "image2"]
        photoGallery.backgroundColor = .clear
        photoGallery.setLeftImage(UIImage(named: "gallery_left_arrow"))
        photoGallery.setRightImage(UIImage(named: "gallery_right_arrow"))
        photoGallery.pageTintColor = .clear
        photoGallery.pageIndicatorTintColor = .gray
        photoGallery.currentPageIndicatorTintColor = .cyan
        photoGallery.pagerHeight = 30
        photoGallery.containerPadding = CGSize(width: 20, height: 0)
        photoGallery.delegate = self
        photoGallery.reloadData()
    }
    
    func setupSubGallery(_ photoGallery: ASPhotoGallery) {
        subItems = (0..<20).map({ index in return "image\(index%3)"})
        photoGallery.backgroundColor = .clear
        photoGallery.setLeftImage(UIImage(named: "bx-bxs-left-arrow"))
        photoGallery.setRightImage(UIImage(named: "bx-bxs-right-arrow"))
        photoGallery.pageTintColor = .clear
        photoGallery.pageIndicatorTintColor = .gray
        photoGallery.currentPageIndicatorTintColor = .cyan
        photoGallery.pagerHeight = 0
        photoGallery.containerPadding = CGSize(width: 50, height: 0)
        photoGallery.itemWidth = 50
        photoGallery.stackViewSpacing = 0
        photoGallery.isCustomScroll = true
        photoGallery.arrowPadding = CGPoint(x: 8, y: 0)
        photoGallery.arrowSize = CGSize(width: 30, height: 30)
        photoGallery.delegate = self
        photoGallery.visibleIndex = 1
        photoGallery.reloadData()
        self.perform(#selector(setPage), with: photoGallery, afterDelay: 0.1)
    }
    
    @objc func setPage(_ sender: ASPhotoGallery) {
        sender.setPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reloadEvent(_ sender: Any) {
        photoGallery.reloadData()
    }
}

extension ViewController: ASPhotoGalleryDelegate {
    func asPhotoGalleryNumberOfItems(_ gallery: ASPhotoGallery) -> Int {
        if gallery == photoGallery {
            return items.count
        }else {
            return subItems.count
        }
    }
    
    func asPhotoGallery(_ gallery: ASPhotoGallery, itemAt index: Int) -> UIView {
        if gallery == photoGallery {
            let bannerView = BannerView()
            bannerView.tag = index
            bannerView.imageView.image = UIImage(named: items[index])
            bannerView.delegate = self
            return bannerView
        }else {
            let bannerView = BannerSubView()
            bannerView.tag = index
            bannerView.imageView.image = UIImage(named: subItems[index])
            bannerView.delegate = self
            return bannerView
        }
    }
    
    func asPhotoGallery(_ gallery: ASPhotoGallery, selected view: UIView, didSelectAt index: Int) {
        if gallery == photoGallery {
            print("index: \(index)")
        }else {
            print("subIndex: \(index)")
            let item = subItems[index]
            subItemImageView.image = UIImage(named: item)
        }
    }
}

extension ViewController: BannerViewDelegate {
    func bannerReadMoreEvent(_ view: BannerView) {
    }
}

extension ViewController: BannerSubViewDelegate {
    func bannerSubReadMoreEvent(_ view: BannerSubView) {
    }
}
