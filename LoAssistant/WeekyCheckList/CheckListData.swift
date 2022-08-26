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
    
    var argos: Int
    var valtan: Int
    var biakiss: Int
    var kouku_saton: Int
    var kayangel: Int
    var abrelshud_12: Int
    var abrelshud_34: Int
    var abrelshud_56: Int
    var illiakan: Int
}
