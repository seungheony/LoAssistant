//
//  TestTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/02.
//

import UIKit

class OrehaTableViewController: UITableViewController {
    let itemList: [String] = ["고대 유물", "희귀한 유물", "오레하 유물", "중급 오레하 융화 재료", "상급 오레하 융화 재료"]
    
    let imageList: [String] = ["ancient.png", "rare.png", "oreha.png", "intermediate.png", "advanced.png"]
    let sysImageList: [String] = ["g.circle.fill", "g.circle.fill", "plus", "plus"]
    
    let marketURL: [String] = [ "http://152.70.248.4:5000/trade/6882701", "http://152.70.248.4:5000/trade/6882704",
                                "http://152.70.248.4:5000/trade/6885708", "http://152.70.248.4:5000/trade/6861008",
                                "http://152.70.248.4:5000/trade/6861009" ]
    
    @IBAction func settingButton(_ sender: Any) {
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
    
    var intermediateProfit: String = ""
    var interExtraProfit: String = ""
    
    var advancedProfit: String = ""
    var advExtraProfit: String = ""
    
    var counter = 0
    var firstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefreshControl()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 0
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 2
        } else if section == 4 {
            return 2
        } else if section == 5 {
            return 2
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "고고학 재료 시세"
        } else if section == 2 {
            return "오레하 융화 재료 시세"
        } else if section == 4 {
            return "사이클당 순수익"
        } else if section == 5 {
            return "대성공시 추가 이득"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrehaCell", for: indexPath) as! OrehaTableViewCell

        if indexPath.section == 1 {
            cell.itemImage.image = UIImage(named: imageList[indexPath.row])
            cell.itemLabel.text = itemList[indexPath.row]
            if firstLoad == false {
                if indexPath.row == 0 {
                    cell.goldLabel.text = (self.ancient[0].price ?? "0") + " G"
                } else if indexPath.row == 1 {
                    cell.goldLabel.text = (self.rare[0].price ?? "0") + " G"
                } else if indexPath.row == 2 {
                    cell.goldLabel.text = (self.oreha[0].price ?? "0") + " G"
                }
            }
            
        } else if indexPath.section == 2 {
            cell.itemImage.image = UIImage(named: imageList[indexPath.row + 3])
            cell.itemLabel.text = itemList[indexPath.row + 3]
            if firstLoad == false {
                if indexPath.row == 0 {
                    cell.goldLabel.text = String(Int(get_intermediatePrice())) + " G"
                } else if indexPath.row == 1 {
                    cell.goldLabel.text = String(Int(get_advancedPrice())) + " G"
                }
            }
        } else if indexPath.section == 4 {
            cell.itemImage.image = UIImage(systemName: sysImageList[indexPath.row])
            cell.itemLabel.text = itemList[indexPath.row + 3]
            if firstLoad == false {
                if indexPath.row == 0 {
                    cell.goldLabel.text = intermediateProfit
                } else if indexPath.row == 1 {
                    cell.goldLabel.text = advancedProfit
                }
            }
        } else if indexPath.section == 5 {
            cell.itemImage.image = UIImage(systemName: sysImageList[indexPath.row + 2])
            cell.itemLabel.text = itemList[indexPath.row + 3]
            if firstLoad == false {
                if indexPath.row == 0 {
                    cell.goldLabel.text = interExtraProfit
                } else if indexPath.row == 1 {
                    cell.goldLabel.text = advExtraProfit
                }
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
            nextVC.isMaterial = true
            nextVC.ancient = ancient
            nextVC.rare = rare
            nextVC.oreha = oreha
            self.present(nextVC, animated: true)
        }
        if indexPath.section == 2 {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
            nextVC.intermediate_oreha = intermediate_oreha
            nextVC.advanced_oreha = advanced_oreha
            self.present(nextVC, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 4 {
            return nil
        } else if indexPath.section == 5 {
            return nil
        }
        return indexPath
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
                    self.oreha = marketData
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
        calculator()
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
        
        let inter_cost = 200 * (100-reduction) / 100
        let advanced_cost = 250 * (100-reduction) / 100
        
        var total_cost = inter_materialPrice + inter_cost
        intermediateProfit =  String((((get_interSalePrice()*30) - total_cost) * 10) * 제작슬롯) + " G"
        interExtraProfit = String(get_interSalePrice()*30) + " G"
        
        total_cost = advanced_materialPrice + advanced_cost
        advancedProfit =  String((((get_advSalePrice()*20) - total_cost) * 10) * 제작슬롯) + " G"
        advExtraProfit = String((get_advSalePrice()*20)) + " G"
        self.tableView.reloadData()
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
        firstLoad = false
        parseData(url: marketURL[0])
    }
}

