//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Nguyen Huu Hung on 8/8/25.
//

import Foundation

struct JSONMenu: Codable {
    let menuItems: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menuItems = "menu"
    }
}


struct MenuItem: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}


