//
//  Models.swift
//  Demo
//
//  Created by RCD on 23/11/2022.
//

import Foundation


struct MainData: Codable {
    let result: ShopData
}

struct ShopData: Codable {
    let status: String
    let canLoad: Bool
    let data, featuredItems: [ProductData]
    let shopName: String
    let shopReviewsCount: Int
    let shopBanner, shopLogo: String
    let shopRating, shopRatingDEC: Int
    let shopRatingCount: String
    let sameDayDelivery, pickup: Bool
    let preparationTime: String

    enum CodingKeys: String, CodingKey {
        case status
        case canLoad = "can_load"
        case data
        case featuredItems = "featured_items"
        case shopName = "shop_name"
        case shopReviewsCount = "shop_reviews_count"
        case shopBanner = "shop_banner"
        case shopLogo = "shop_logo"
        case shopRating = "shop_rating"
        case shopRatingDEC = "shop_rating_dec"
        case shopRatingCount = "shop_rating_count"
        case sameDayDelivery = "same_day_delivery"
        case pickup
        case preparationTime = "preparation_time"
    }
}

struct ProductData: Codable {
    let flowerID: String
    let productID: Int
    let itemName, shopName: String
    let pic: String
    let currency: Currency
    let pricePer: Double
    let price, oldPrice: String
    let sellByMin, maxQuantity: Int
    let sellByUnit: String
    let sellBy: String
    let sameDayDelivery: Bool
    let isFavorite, adOverlay, personalization: Bool?
    let distance: Distance
    let recordID: String?

    enum CodingKeys: String, CodingKey {
        case flowerID = "flower_id"
        case productID = "product_id"
        case itemName = "item_name"
        case shopName = "shop_name"
        case pic, currency
        case pricePer = "price_per"
        case price
        case oldPrice = "old_price"
        case sellByMin = "sell_by_min"
        case maxQuantity = "max_quantity"
        case sellByUnit = "sell_by_unit"
        case sellBy = "sell_by"
        case sameDayDelivery = "same_day_delivery"
        case isFavorite = "is_favorite"
        case adOverlay = "ad_overlay"
        case personalization, distance
        case recordID = "record_id"
    }
}

enum Currency: String, Codable {
    case kwd = "KWD"
}

enum Distance: String, Codable {
    case the0KM = "0 km"
}
