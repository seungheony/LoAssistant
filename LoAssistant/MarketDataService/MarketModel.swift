//
//  MarketModel.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/05/13.
//

import UIKit

// MARK: - MarketModel
struct MarketModel: Codable {
    let name: String
    let pricechart: [Pricechart]?
    let result: String

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case pricechart = "Pricechart"
        case result = "Result"
    }
}

// MARK: - Pricechart
struct Pricechart: Codable {
    let amount, price: String?

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case price = "Price"
    }
}
