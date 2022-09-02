//
//  CheckListData.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/18.
//

import Foundation

struct CheckList: Codable {
    var earnGold: Bool
    var counter: Int
    
    var char_name: String
    var char_level: Float
    var char_class: String
    
    var argos: Int
    var valtan: Int
    var biakiss: Int
    var kouku_saton: Int
    var kayangel: Int
    var abrelshud: Int
    var illiakan: Int
}
