//
//  Date.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/29.
//

import Foundation

extension Date {

    /**
     # dateCompare
     - Parameters:
        - fromDate: 비교 대상 Date
     - Note: 두 날짜간 비교해서 과거(Future)/현재(Same)/미래(Past) 반환
    */
    public func isPast(fromDate: Date) -> Bool {
        var result: Bool = false
        let comp_result:ComparisonResult = self.compare(fromDate)
        switch comp_result {
        case .orderedAscending:
            result = false
            break
        case .orderedDescending:
            result = true
            break
        case .orderedSame:
            result = false
            break
        default:
            result = false
            break
        }
        return result
    }
}
