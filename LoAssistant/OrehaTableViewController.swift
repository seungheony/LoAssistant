//
//  OrehaTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/27.
//

import UIKit

class OrehaTableViewController: UITableViewController {

    @IBOutlet weak var ancientPrice: UILabel!
    @IBOutlet weak var rarePrice: UILabel!
    @IBOutlet weak var orehaPrice: UILabel!
    
    var ancient = [Pricechart]()
    var rare = [Pricechart]()
    var oreha = [Pricechart]()
    
    var intermediate_oreha = [Pricechart]()
    var advanced_oreha = [Pricechart]()
    
    var counter = 0
    let marketURL: [String] = [ "http://152.70.248.4:5000/trade/6882701", "http://152.70.248.4:5000/trade/6882704",
                                "http://152.70.248.4:5000/trade/6885708", "http://152.70.248.4:5000/trade/6861008",
                                "http://152.70.248.4:5000/trade/6861009" ]
    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in marketURL {
//            parseData(url: i)
//        }
        parseData(url: marketURL[0])
        
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 3
        }
        else if(section == 1){
            return 2
        }
        else if(section == 2){
            return 2
        }
        else {
            return 2
        }
    }
}

extension OrehaTableViewController {
    
    func parseData(url: String) {
        GetMarketDataService.shared.getMarketInfo(URL: url) { (response) in
            // NetworkResult형 enum값을 이용해서 분기처리를 합니다.
            switch(response) {
            
            // 성공할 경우에는 <T>형으로 데이터를 받아올 수 있다고 했기 때문에 Generic하게 아무 타입이나 가능하기 때문에
            // 클로저에서 넘어오는 데이터를 let personData라고 정의합니다.
            case .success(let marketData):
                // personData를 Person형이라고 옵셔널 바인딩 해주고, 정상적으로 값을 data에 담아둡니다.
                switch(self.counter) {
                case 0:
                    print(self.counter)
                    self.ancient = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[1])
                case 1:
                    print(self.counter)
                    self.rare = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[2])
                case 2:
                    print(self.counter)
                    print(marketData.self)
                    self.counter+=1
                    self.parseData(url: self.marketURL[3])
                case 3:
                    print(self.counter)
                    self.intermediate_oreha = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[4])
                case 4:
                    print(self.counter)
                    self.advanced_oreha = marketData
                default: break
                }
               
            // 실패할 경우에 분기처리는 아래와 같이 합니다.
            case .requestErr(let message) :
                print("requestErr", message)
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
