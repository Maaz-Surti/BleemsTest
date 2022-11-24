//
//  BaseCollectionView.swift
//  Demo
//
//  Created by RCD on 24/11/2022.
//

import Foundation
import UIKit

class BaseCollectionView: UICollectionView {
    
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        let s = self.collectionViewLayout.collectionViewContentSize
        return CGSize(width: max(s.width, 0), height: max(s.height,0))
    }
}
