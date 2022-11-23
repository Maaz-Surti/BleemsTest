//
//  ItemCell.swift
//  Demo
//
//  Created by RCD on 23/11/2022.
//

import Foundation
import UIKit
import SDWebImage

class ItemCell: UICollectionViewCell {
    
    static let identifier = "ItemCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        //contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkGray
        
        addSubview(productImage)
        addSubview(sameDayDeliveryLabel)
        
        setConstraints()
        
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            productImage.topAnchor.constraint(equalTo: topAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 140),
            
            sameDayDeliveryLabel.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            sameDayDeliveryLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            sameDayDeliveryLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
            sameDayDeliveryLabel.heightAnchor.constraint(equalToConstant: 25),
        
        ])
    }
    
    func configure(with model: FeaturedItem) {

        productImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        productImage.sd_imageTransition = .fade
        productImage.sd_setImage(with: URL(string: model.photo)!)
        
        //productImage.downloadImage(model.photo)
        
        sameDayDeliveryLabel.isHidden = !model.sameDayDelivery

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
