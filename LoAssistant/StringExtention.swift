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
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func removeStrikeThrough() -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    mutating func setRaidNameAtAttributesStr(add: String) -> NSMutableAttributedString {
        let difficulty: [String] = [" 하드-3", " 하드-2", " 하드-1", " 노말", " 하드"]
        for i in 0...difficulty.count-1 {
            if let range = self.range(of: difficulty[i]) {
                self.removeSubrange(range)
            }
        }
        
        let raidName: String = self + " " + add
        let attributedStr = NSMutableAttributedString(string: raidName)
        
        let font = UIFont.systemFont(ofSize: 11
        )
        attributedStr.addAttribute(.font, value: font, range: (raidName as NSString).range(of: add))
        
        if add.contains("하드") {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (raidName as NSString).range(of: add))
        } else {
            attributedStr.addAttribute(.foregroundColor, value: UIColor.lightGray, range: (raidName as NSString).range(of: add))
        }
        return attributedStr
    }
}
