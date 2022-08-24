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
    
    var 아르고스: Bool
    var 발탄노말: Bool
    var 비아키스노말: Bool
    var 발탄하드: Bool
    var 비아키스하드: Bool
    var 쿠크세이튼: Bool
    var 카양겔노말: Bool
    var 아브12노말: Bool
    var 아브34노말: Bool
    var 아브56노말: Bool
    var 카양겔하드1: Bool
    var 아브12하드: Bool
    var 아브34하드: Bool
    var 아브56하드: Bool
    var 카양겔하드2: Bool
    var 카양겔하드3: Bool
}
