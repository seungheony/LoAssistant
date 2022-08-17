//
//  CharacterDataService.swift
//  LoAssistant
//
//  Created by shkim on 2022/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

extension CharacterTableViewController {
    func parseCaracterData(url: String, handler: @escaping (JSON) -> Void) {
        let request = AF.request(encodeURL(url: url))
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func encodeURL(url: String) -> URL{
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedURL = URL(string: encodedStr)!
        
        return encodedURL
    }
}
