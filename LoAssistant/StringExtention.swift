//
//  StringExtention.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import Foundation
import UIKit

extension String {
    func strikeThrough() -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func removeStrikeThrough() -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    mutating func setRaidNameAtAttributesStr(add: String) -> NSMutableAttributedString {
        if let range = self.range(of: " " + add) {
            self.removeSubrange(range)
        }
        let raidName: String = self + " " + add
        let attributedStr = NSMutableAttributedString(string: raidName)
        
        if add.contains("하드") {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (raidName as NSString).range(of: add))
        } else {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (raidName as NSString).range(of: add))
        }
        return attributedStr
    }
}
