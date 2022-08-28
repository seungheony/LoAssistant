//
//  CheckListData.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/18.
//

import Foundation

struct CheckList: Codable {
    var earnGold: Bool
    var changeability: Bool
    
    var char_name: String
    var char_level: Float
    var char_class: String
    
    var argos: Bool
    var valtan: Bool
    var biakiss: Bool
    var kouku_saton: Bool
    var kayangel: Int
    var abrelshud: Int
    var illiakan: Bool
}
