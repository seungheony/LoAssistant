//
//  CrystalModel.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/01.
//

import Foundation

struct CrystalModel: Codable {
    let buy, sell: String

    enum CodingKeys: String, CodingKey {
        case buy = "Buy"
        case sell = "Sell"
    }
}
