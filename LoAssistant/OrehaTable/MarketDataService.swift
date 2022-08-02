//
//  MarketService.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON

extension OrehaTableViewController {
    func parseMarketData(url: String, handler: @escaping (JSON) -> Void) {
        let request = AF.request(url)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
