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
    let description: String
    let image: String
    let category: String
}
