//
//  SwiftyJSON.swift
//  LoAssistant
//
//  Created by shkim on 2022/07/29.
//

import Foundation
import Alamofire
import SwiftyJSON

extension PheonViewController {
    func parseCrystalData(url: String, handler: @escaping (JSON) -> Void) {
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
