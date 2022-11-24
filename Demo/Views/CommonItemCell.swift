//
//  CommonItemCell.swift
//  Demo
//
//  Created by Maaz on 24/11/22.
//

import Foundation
import UIKit

class CommonItemCell: UICollectionViewCell {
    
    static let identifier = "CommonItemCell"
    
    let productImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    let sameDayDeliveryLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Same Day Delivery"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.isHidden = true
        label.backgroundColor = .black.withAlphaComponent(0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let kwdLabel: UILabel = {
        
        let label = UILabel()
        label.text = "KWD"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let priceLabel: UILabel = {
        
        let label = UILabel()
        label.text = "28.085"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let shopNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "The Florist"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
