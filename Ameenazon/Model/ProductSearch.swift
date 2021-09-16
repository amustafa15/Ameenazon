//
//  ProductDetails.swift
//  Ameenazon
//
//  Created by Ameen Mustafa on 8/5/21.
//


import Foundation


// MARK: - ProductSearch
struct ProductSearch: Codable {
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products
    }
}

// MARK: - Product
struct Product: Codable {
    let asin: String
    let price: Price
    let reviews: Reviews
    let url: String
    let amazonPrime: Bool
    let title: String
    let thumbnail: String
}

// MARK: - Price
struct Price: Codable {
    let currentPrice: Double

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let totalReviews: Int
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case totalReviews = "total_reviews"
        case rating
    }
}
