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
    @IBOutlet weak var intermediatePrice: UILabel!
    @IBOutlet weak var advancedPrice: UILabel!
    
    @IBOutlet weak var intermediateProfit: UILabel!
    @IBOutlet weak var advancedProfit: UILabel!
    @IBOutlet weak var interExtraProfit: UILabel!
    @IBOutlet weak var advExtraProfit: UILabel!
    
    @IBAction func orehaSetting(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "OrehaSetting") as? OrehaSettingViewController else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
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
//        parseData(url: marketURL[0])
        setRefreshControl()
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
    
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "ancient",
           let dest = segue.destination as? PriceTableViewController {
            dest.ancient = self.ancient
            dest.rare = self.rare
            dest.oreha = self.oreha
            dest.isMaterial = true
        }
        else if segue.identifier == "rare",
           let dest = segue.destination as? PriceTableViewController {
            dest.ancient = self.ancient
            dest.rare = self.rare
            dest.oreha = self.oreha
            dest.isMaterial = true
        }
        else if segue.identifier == "oreha",
           let dest = segue.destination as? PriceTableViewController {
            dest.ancient = self.ancient
            dest.rare = self.rare
            dest.oreha = self.oreha
            dest.isMaterial = true
        }
        else if segue.identifier == "intermediate",
           let dest = segue.destination as? PriceTableViewController {
            dest.intermediate_oreha = self.intermediate_oreha
            dest.advanced_oreha = self.advanced_oreha
        }
        else if segue.identifier == "advanced",
           let dest = segue.destination as? PriceTableViewController {
            dest.intermediate_oreha = self.intermediate_oreha
            dest.advanced_oreha = self.advanced_oreha
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
                    self.ancient = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[1])
                case 1:
                    self.rare = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[2])
                case 2:
                    self.oreha = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[3])
                case 3:
                    self.intermediate_oreha = marketData
                    self.counter+=1
                    self.parseData(url: self.marketURL[4])
                case 4:
                    self.advanced_oreha = marketData
                    self.counter = 0
                    self.setPrice()
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
    
    func setPrice() {
        ancientPrice.text = String(Int(get_ancientPrice())) + " G"
        rarePrice.text = String(Int(get_rarePrice())) + " G"
        orehaPrice.text = String(Int(get_orehaPrice())) + " G"
        intermediatePrice.text = String(Int(get_intermediatePrice())) + " G"
        advancedPrice.text = String(Int(get_advancedPrice())) + " G"
        calculator()
        // refreshing 종료
        tableView.refreshControl?.endRefreshing()
    }
    
    func calculator() {
        var 설치물: Int = 0
        var 의상: Int = 0
        var 연구: Int = 0
        
        var reduction: Int = 0
        
        var 제작슬롯: Int = 1
        
        설치물 += Int(truncating: UserDefaults.standard.bool(forKey: "여신의가호") as NSNumber)
        설치물 += Int(truncating: UserDefaults.standard.bool(forKey: "ASML") as NSNumber) * 4
        
        의상 += Int(truncating: UserDefaults.standard.bool(forKey: "페일린") as NSNumber) * 2
        의상 += Int(truncating: UserDefaults.standard.bool(forKey: "니아") as NSNumber)
        의상 += Int(truncating: UserDefaults.standard.bool(forKey: "실리안") as NSNumber)
        
        연구 += Int(truncating: UserDefaults.standard.bool(forKey: "가림막") as NSNumber)
        연구 += Int(truncating: UserDefaults.standard.bool(forKey: "자급자족") as NSNumber)
        연구 += Int(truncating: UserDefaults.standard.bool(forKey: "발전기") as NSNumber)
        연구 += Int(truncating: UserDefaults.standard.bool(forKey: "커피머신") as NSNumber)
        
        if (UserDefaults.standard.bool(forKey: "니나브") && 의상 == 4) {
            의상 -= 1
        }
        reduction = 설치물 + 의상 + 연구
        
        if Int(UserDefaults.standard.integer(forKey: "제작공방")) >= 3 {
            if Int(UserDefaults.standard.integer(forKey: "제작공방")) >= 5 {
                제작슬롯 = 3
            } else {
                제작슬롯 = 2
            }
        } else {
            제작슬롯 = 1
        }
        제작슬롯 += Int(truncating: UserDefaults.standard.bool(forKey: "니나브") as NSNumber)
        
        let inter_materialPrice = Int(trunc((get_ancientPrice()*0.64) + (get_rarePrice()*2.6) + (get_orehaPrice()*0.8)))
        let advanced_materialPrice = Int(trunc((get_ancientPrice()*0.94) + (get_rarePrice()*2.9) + (get_orehaPrice()*1.6)))
        
        print("중급 재료 : \(inter_materialPrice)")
        print("상급 재료 : \(advanced_materialPrice)")
        
        let inter_cost = 200 * (100-reduction) / 100
        let advanced_cost = 250 * (100-reduction) / 100
        
        var total_cost = inter_materialPrice + inter_cost
        print("total_cost : \(total_cost)")
        print(get_interSalePrice())
        print(Int(truncating: UserDefaults.standard.float(forKey: "중급기준") as NSNumber) * 1000)
        intermediateProfit.text =  String((((get_interSalePrice()*30) - total_cost) * 10) * 제작슬롯) + " G"
        interExtraProfit.text = String(get_interSalePrice()*30) + " G"
        
        total_cost = advanced_materialPrice + advanced_cost
        print("total_cost : \(total_cost)")
        print(get_advSalePrice())
        print(Int(truncating: UserDefaults.standard.float(forKey: "상급기준") as NSNumber) * 1000)
        advancedProfit.text =  String((((get_advSalePrice()*20) - total_cost) * 10) * 제작슬롯) + " G"
        advExtraProfit.text = String((get_advSalePrice()*20)) + " G"
        
    }
    
    func get_ancientPrice() -> Double {
        let price: Double = Double(self.ancient[0].price!)!
        return price
    }
    
    func get_rarePrice() -> Double {
        let price: Double = Double(self.rare[0].price!)!
        return price
    }
    
    func get_orehaPrice() -> Double {
        let price: Double = Double(self.oreha[0].price!)!
        return price
    }
    
    func get_intermediatePrice() -> Double {
        if self.intermediate_oreha.count == 1 {
            let price: Double = Double(self.intermediate_oreha[0].price!)!
            return price
        } else {
            if Int(self.intermediate_oreha[0].amount!) ?? 0 < (Int(truncating: UserDefaults.standard.float(forKey: "중급기준") as NSNumber) * 1000) {
                let price: Double = Double(self.intermediate_oreha[self.intermediate_oreha.count-1].price!)!
                print("중급 가격 : \(price)")
                return price
            } else {
                let price: Double = Double(self.intermediate_oreha[0].price!)!
                return price
            }
        }
    }
    func get_advancedPrice() -> Double {
        if self.advanced_oreha.count == 1 {
            let price: Double = Double(self.advanced_oreha[0].price!)!
            return price
        } else {
            if Int(self.advanced_oreha[0].amount!) ?? 0 < (Int(truncating: UserDefaults.standard.float(forKey: "상급기준") as NSNumber) * 1000) {
                let price: Double = Double(self.advanced_oreha[self.advanced_oreha.count-1].price!)!
                print("상급 가격 : \(price)")
                return price
            } else {
                let price: Double = Double(self.advanced_oreha[0].price!)!
                return price
            }
        }
    }
    func get_interSalePrice() -> Int {
        let commission = Int(ceil(get_intermediatePrice() * 0.05))
        return Int(get_intermediatePrice()) - commission
    }
    func get_advSalePrice() -> Int {
        let commission = Int(ceil(get_advancedPrice() * 0.05))
        return Int(get_advancedPrice()) - commission
    }
}

extension OrehaTableViewController {
    
    func setRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        // 테이블뷰에 입력되는 데이터를 갱신한다.
        parseData(url: marketURL[0])
    }
}
