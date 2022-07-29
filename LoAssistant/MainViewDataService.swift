//
//  SwiftyJSON.swift
//  LoAssistant
//
//  Created by shkim on 2022/07/29.
//

import Foundation
import Alamofire
import SwiftyJSON

extension MainTableViewController {
    func parseCrystalData(url: String) {
        AF.request(url).responseJSON {
            response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let crystal = json["Buy"].doubleValue
                self.crystalJSON = json
                self.crystal = crystal
            default:
                return
            }
        }
    }
}
