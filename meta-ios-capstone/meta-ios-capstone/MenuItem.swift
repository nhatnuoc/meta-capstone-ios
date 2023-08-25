//
//  MenuItem.swift
//  meta-ios-capstone
//
//  Created by Nguyễn Thanh Bình on 31/07/2023.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    let id: Int
    let title: String
    let price: String
    let description_: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description_ = "description"
        case image
        case category
    }
}
