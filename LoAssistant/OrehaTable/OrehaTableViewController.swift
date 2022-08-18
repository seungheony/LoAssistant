//
//  TestTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/02.
//

import UIKit
import SwiftyJSON

class OrehaTableViewController: UITableViewController {
    let itemList: [String] = ["고대 유물", "희귀한 유물", "오레하 유물", "중급 오레하 융화 재료", "상급 오레하 융화 재료"]
    
    let imageList: [String] = ["ancient.png", "rare.png", "oreha.png", "intermediate.png", "advanced.png"]
    let sysImageList: [String] = ["g.circle.fill", "g.circle.fill", "plus", "plus"]
    
    let marketURL: [String] = [ "https://lostarkapi.ga/trade/6882701", "https://lostarkapi.ga/trade/6882704",
                                "https://lostarkapi.ga/trade/6885708", "https://lostarkapi.ga/trade/6861008",
                                "https://lostarkapi.ga/trade/6861009" ]
    // 가격 데이터 변수
    var ancient = JSON()
    var rare = JSON()
    var oreha = JSON()
    
    var intermediate_oreha = JSON()
    var advanced_oreha = JSON()
    
    // 이득 데이터 변수
    var intermediateProfit: String = ""
    var interExtraProfit: String = ""
    
    var advancedProfit: String = ""
    var advExtraProfit: String = ""
    
    var counter = 0
    var firstLoad = true
    
    @IBAction func settingButton(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "OrehaSetting") as? OrehaSettingViewController else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRefreshControl()
//        LoadingHUD.show()
//
//        parseMarketData(url: marketURL[0]) { (data) in
//            self.ancient = data
//        }
//        parseMarketData(url: marketURL[1]) { (data) in
//            self.rare = data
//        }
//        parseMarketData(url: marketURL[2]) { (data) in
//            self.oreha = data
//        }
//        parseMarketData(url: marketURL[3]) { (data) in
//            self.intermediate_oreha = data
//        }
//        parseMarketData(url: marketURL[4]) { (data) in
//            self.advanced_oreha = data
//            self.setRefreshControl()
//            print("데이터 파싱 완료")
//            LoadingHUD.hide()
//            self.tableView.reloadData()
//
//            // viewDidLoad에서 데이터 파싱하고
//            // refreshControl 세팅도 같이 하고 싶었지만.... 어케 하누...
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            if firstLoad == true {
                return 1
            }
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 2
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return 1
        } else if section == 6 {
            return 1
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
        } else if section == 6 {
            return "제작 완료 알리미"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orehaCell = tableView.dequeueReusableCell(withIdentifier: "OrehaCell", for: indexPath) as! OrehaTableViewCell
        let resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
        if firstLoad == true {
            if indexPath.section == 0 {
                let howToUseCell = tableView.dequeueReusableCell(withIdentifier: "HowToUseCell", for: indexPath) as! HowToUseTableViewCell
                if indexPath.row == 0 {
                    return howToUseCell
                }
                return howToUseCell
            }
        }
        
        if indexPath.section == 1 {
            orehaCell.itemImage.image = UIImage(named: imageList[indexPath.row])
            orehaCell.itemLabel.text = itemList[indexPath.row]
            if firstLoad == false {
                if indexPath.row == 0 {
                    orehaCell.goldLabel.text = (self.ancient["Pricechart"].array![0]["Price"].stringValue) + " G"
                } else if indexPath.row == 1 {
                    orehaCell.goldLabel.text = (self.rare["Pricechart"].array![0]["Price"].stringValue) + " G"
                } else if indexPath.row == 2 {
                    orehaCell.goldLabel.text = (self.oreha["Pricechart"].array![0]["Price"].stringValue) + " G"
                }
            }
            return orehaCell
        } else if indexPath.section == 2 {
            orehaCell.itemImage.image = UIImage(named: imageList[indexPath.row + 3])
            orehaCell.itemLabel.text = itemList[indexPath.row + 3]
            if firstLoad == false {
                if indexPath.row == 0 {
                    orehaCell.goldLabel.text = String(Int(get_intermediatePrice())) + " G"
                } else if indexPath.row == 1 {
                    orehaCell.goldLabel.text = String(Int(get_advancedPrice())) + " G"
                }
            }
            return orehaCell
        } else if indexPath.section == 4 {
            resultCell.interImage.image = UIImage(named: imageList[3])
            resultCell.advImage.image = UIImage(named: imageList[4])
            if firstLoad == false {
                if indexPath.row == 0 {
                    resultCell.interPrice.text = intermediateProfit
                    resultCell.advPrice.text = advancedProfit
                }
            }
            return resultCell
        } else if indexPath.section == 5 {
            resultCell.interImage.image = UIImage(named: imageList[3])
            resultCell.advImage.image = UIImage(named: imageList[4])
            if firstLoad == false {
                if indexPath.row == 0 {
                    resultCell.interPrice.text = interExtraProfit
                    resultCell.advPrice.text = advExtraProfit
                }
            }
            return resultCell
        } else if indexPath.section == 6 {
            let timerCell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerTableViewCell
            if indexPath.row == 0 {
                return timerCell
            }
            return timerCell
        }
        return orehaCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && !firstLoad {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
            nextVC.isMaterial = true
            nextVC.ancient = ancient
            nextVC.rare = rare
            nextVC.oreha = oreha
            self.present(nextVC, animated: true)
        }
        if indexPath.section == 2 && !firstLoad {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
            nextVC.intermediate_oreha = intermediate_oreha
            nextVC.advanced_oreha = advanced_oreha
            self.present(nextVC, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            return nil
        } else if indexPath.section == 4 {
            return nil
        } else if indexPath.section == 5 {
            return nil
        } else if indexPath.section == 6 {
            return nil
        }
        return indexPath
    }
}

extension OrehaTableViewController {
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
        
        if UserDefaults.standard.integer(forKey: "제작공방") >= 3 {
            if UserDefaults.standard.integer(forKey: "제작공방") >= 5 {
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
        let price: Double = Double(self.ancient["Pricechart"].array![0]["Price"].stringValue)!
        return price
    }
    
    func get_rarePrice() -> Double {
        let price: Double = Double(self.rare["Pricechart"].array![0]["Price"].stringValue)!
        return price
    }
    
    func get_orehaPrice() -> Double {
        let price: Double = Double(self.oreha["Pricechart"].array![0]["Price"].stringValue)!
        return price
    }
    
    func get_intermediatePrice() -> Double {
        if self.intermediate_oreha["Pricechart"].array!.count == 1 {
            let price: Double = Double(self.intermediate_oreha["Pricechart"].array![0]["Price"].stringValue)!
            return price
        } else {
            if Int(self.intermediate_oreha["Pricechart"].array![0]["Amount"].stringValue) ?? 0 < (Int(truncating: UserDefaults.standard.float(forKey: "중급기준") as NSNumber) * 1000) {
                let price: Double = Double(self.intermediate_oreha["Pricechart"].array![1]["Price"].stringValue)!
                return price
            } else {
                let price: Double = Double(self.intermediate_oreha["Pricechart"].array![0]["Price"].stringValue)!
                return price
            }
        }
    }
    func get_advancedPrice() -> Double {
        if self.advanced_oreha["Pricechart"].array!.count == 1 {
            let price: Double = Double(self.advanced_oreha["Pricechart"].array![0]["Price"].stringValue)!
            return price
        } else {
            if Int(self.advanced_oreha["Pricechart"].array![0]["Amount"].stringValue) ?? 0 < (Int(truncating: UserDefaults.standard.float(forKey: "상급기준") as NSNumber) * 1000) {
                let price: Double = Double(self.advanced_oreha["Pricechart"].array![1]["Price"].stringValue)!
                return price
            } else {
                let price: Double = Double(self.advanced_oreha["Pricechart"].array![0]["Price"].stringValue)!
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
        print("refresh")
        firstLoad = false
        
        parseMarketData(url: marketURL[0]) { (data) in
            self.ancient = data
            print(data["Result"].stringValue)
            if data["Result"].stringValue == "Failed" {
                let alert = UIAlertController(title: "오류 발생", message: data["Reason"].stringValue, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
                self.tableView.refreshControl?.endRefreshing()
            } else {
                self.parseMarketData(url: self.marketURL[1]) { (data) in
                    self.rare = data
                    self.parseMarketData(url: self.marketURL[2]) { (data) in
                        self.oreha = data
                        self.parseMarketData(url: self.marketURL[3]) { (data) in
                            self.intermediate_oreha = data
                            self.parseMarketData(url: self.marketURL[4]) { (data) in
                                self.advanced_oreha = data
                                self.setPrice()
                            }
                        }
                    }
                }
            }
        }
    }
}

