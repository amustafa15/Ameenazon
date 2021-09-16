//
//  Product.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 7/14/21.
//

import Foundation

// MARK: - ProductDetail
struct ProductDetail: Codable {
    let product: Products
}

// MARK: - Product
struct Products: Codable {
    let asin, deliveryMessage, productDescription: String
    let featureBullets: [String]
    let images: [String]
    let mainImage: String
    let price: Prices
    let productInformation: ProductInformation
    let reviews: Review
    let title: String
    let totalImages, totalVideos: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case asin
        case deliveryMessage = "delivery_message"
        case productDescription = "description"
        case featureBullets = "feature_bullets"
        case images
        case mainImage = "main_image"
        case price
        case productInformation = "product_information"
        case title
        case reviews
        case totalImages = "total_images"
        case totalVideos = "total_videos"
        case url
    }
}

// MARK: - Price
struct Prices: Codable {
    let beforePrice: Double
    let currency: String
    let currentPrice: Double
    let discounted: Bool
    let savingsAmount, savingsPercent: Double
    let symbol: String

    enum CodingKeys: String, CodingKey {
        case beforePrice = "before_price"
        case currency
        case currentPrice = "current_price"
        case discounted
        case savingsAmount = "savings_amount"
        case savingsPercent = "savings_percent"
        case symbol
    }
}

// MARK: - ProductInformation
struct ProductInformation: Codable {
    let manufacturer: String

    enum CodingKeys: String, CodingKey {
        case manufacturer
    }
}

// MARK: - Reviews
struct Review: Codable {
    let answeredQuestions: Int
    let rating: String
    let totalReviews: Int

    enum CodingKeys: String, CodingKey {
        case answeredQuestions = "answered_questions"
        case rating
        case totalReviews = "total_reviews"
    }
}
