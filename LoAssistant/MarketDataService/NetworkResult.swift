//
//  NetworkResult.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/05/27.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
