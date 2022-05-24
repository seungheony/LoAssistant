//
//  MarketModel.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/05/13.
//

import UIKit

protocol MarketModelProtocol {
    func ancientRetrieved(ancient:[Pricechart])
    func rareRetrieved(rare:[Pricechart])
    func orehaRetrieved(oreha:[Pricechart])
    func intermediateRetrieved(intermediate: [Pricechart])
    func advancedRetrieved(advanced: [Pricechart])
}

class MarketModel {
    
    var delegate: MarketModelProtocol?
    var counter: Int = 0
    
    func getMarkets(urlString: String) {
        // 2. 해당 스트링으로 URL 인스턴스를 생성해주세요
        let url = URL(string: urlString)
        // 3. 해당 url이 만약에 nil 값이라면 이곳에서 중지할거에요.
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        // 4. URLSession을 만들어줍니다.
        let session = URLSession.shared
        // 5. URLSession을 이용해서 dataTask를 만들어줍니다.
        let datatask = session.dataTask(with: url!) { (data, response, error) in
            // 6. error가 없고 data를 성공적으로 불러왔을때에만 동작합니다.
            if error == nil && data != nil {
                // 7. JSON 데이터를 swift 인스턴스 객체로 바꿔주기 위해서 decoder 객체를 생성합니다.
                let decoder = JSONDecoder()
                // 8. decode함수는 예기치못한 에러를 발생할 수 있으므로 try-catch문을 작성해줍니다. swift문에서는 do-catch문이라고 불러요.
                do{
                    // 9. try 문을 앞에 붙여서 JSON 데이터를 이전에 만들어준 ArticleService 모양의 swift 인스턴스로 파싱해줍니다.
                    let marketService = try decoder.decode(MarketService.self, from: data!)
                    // 10. 데이터를 성공적으로 받아왔다면 일전에 만들어놓은 ArticleModelProtocol의 articlesRetrieved 함수를 이용해서 articles를 ViewController에 보내줍니다. 여기서 주의하셔야 할 점은 ArticleModel의 getArticles 함수는 background thread에서 동작하고 있습니다. 하지만 ViewController에서 articles를 받아오면 바로 화면에 띄워줘야 하기 때문에, UI관련 로직은 많은 프로세스사양을 요구하므로 main thread에서 articlesRetrieved 함수를 동작시켜주어야 합니다. 때문에 DispatchQueue.main.async 구문을 써주었습니다.
//                    DispatchQueue.main.async {
                        switch self.counter {
                        case 0:
                             self.counter+=1
                             print("counter : 0")
                             self.delegate?.ancientRetrieved(ancient: marketService.pricechart!)
                            
                         case 1:
                             self.counter+=1
                             print("counter : 1")
                             self.delegate?.rareRetrieved(rare: marketService.pricechart!)
                         case 2:
                             self.counter+=1
                             print("counter : 2")
                             self.delegate?.orehaRetrieved(oreha: marketService.pricechart!)
                         case 3:
                             self.counter+=1
                             print("counter : 3")
                             self.delegate?.intermediateRetrieved(intermediate:marketService.pricechart!)
                         case 4:
                             self.counter+=1
                             print("counter : 4")
                             self.delegate?.advancedRetrieved(advanced: marketService.pricechart!)
                         default:
                             self.counter = 0
                         }
//                     }
                }
                catch {
                     print("Error parsing the json")
                 }
        }
    }
         // 11. datatask 준비가 완료되었다면 datatask를 실행시켜줍니다.
         datatask.resume()
     }
 }
