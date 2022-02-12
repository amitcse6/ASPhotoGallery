//
//  ASPhotoGallery.swift
//  Gonzo
//
//  Created by AMIT on 2/3/22.
//

import Foundation
import UIKit

public class ASPhotoGalleryClassic: ASPhotoGallery {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
}
