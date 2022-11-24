//
//  CommonItemCell.swift
//  Demo
//
//  Created by Maaz on 24/11/22.
//

import Foundation
import UIKit
import SDWebImage

class CommonItemCell: UICollectionViewCell {
    
    static let identifier = "CommonItemCell"
    
    let productImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
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
    
    
    let priceLabel: UILabel = {
        
        let label = UILabel()
        label.text = "28.085"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let shopNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "The Florist"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.baselineAdjustment = .alignBaselines
        return label
        
    }()
    
    let discountLabel: UILabel = {
        
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let heartButton: UIButton = {
        
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "heart")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       // backgroundColor = .gray
        
        addSubview(productImage)
        addSubview(sameDayDeliveryLabel)
        addSubview(priceLabel)
        addSubview(shopNameLabel)
        addSubview(discountLabel)
        addSubview(heartButton)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            productImage.topAnchor.constraint(equalTo: topAnchor),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 150),
            
            sameDayDeliveryLabel.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            sameDayDeliveryLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            sameDayDeliveryLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
            sameDayDeliveryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 3),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: width/3),
            
            shopNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            shopNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopNameLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 3),
            shopNameLabel.widthAnchor.constraint(equalToConstant: width/2),
            
            discountLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 3),
            discountLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            discountLabel.heightAnchor.constraint(equalToConstant: 10),
            
            heartButton.topAnchor.constraint(equalTo: topAnchor),
            heartButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            heartButton.heightAnchor.constraint(equalToConstant: 20),
        
        ])
    }
    
    func configure(with model: CommonItem) {
        
        productImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        productImage.sd_imageTransition = .fade
        productImage.sd_setImage(with: URL(string: model.photo)!)
        
        //productImage.downloadImage(model.photo)
        
        let itemPrice = model.itemPrice.components(separatedBy: " ")
        
        sameDayDeliveryLabel.isHidden = !model.sameDayDelivery
        
        let attributedPrice = NSAttributedString(string: model.itemPrice).withLineSpacing(2, lineHeight: 14, alignment: .right)
        priceLabel.attributedText = attributedPrice
        
        let attributedShopName = NSAttributedString(string: model.shopName).withLineSpacing(2, lineHeight: 12, alignment: .left)
        shopNameLabel.attributedText = attributedShopName
        
        if model.oldPrice == "" {
            
            discountLabel.text = "20% off"
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
