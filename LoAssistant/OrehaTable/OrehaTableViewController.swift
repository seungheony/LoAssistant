//
//  TestTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/02.
//

import UIKit
import SwiftyJSON

class OrehaTableViewController: UITableViewController {
    let itemList: [String] = ["고대 유물", "희귀한 유물", "오레하 유물", "중급 오레하 융화 재료", "상급 오레하 융화 재료", "최상급 오레하 융화 재료"]
    
    let imageList: [String] = ["ancient.png", "rare.png", "oreha.png", "intermediate.png", "advanced.png", "uppermost.png"]
    let sysImageList: [String] = ["g.circle.fill", "g.circle.fill", "plus", "plus"]
    
    let marketURL: [String] = [ "https://lostarkapi.ga/trade/6882701", "https://lostarkapi.ga/trade/6882704",
                                "https://lostarkapi.ga/trade/6885708", "https://lostarkapi.ga/trade/6861008",
                                "https://lostarkapi.ga/trade/6861009", "https://lostarkapi.ga/trade/6861011" ]
    // 가격 데이터 변수
    var ancient = JSON()
    var rare = JSON()
    var oreha = JSON()
    
    var intermediate_oreha = JSON()
    var advanced_oreha = JSON()
    var uppermost_oreha = JSON()
    
    // 이득 데이터 변수
    var intermediateProfit: String = ""
    var interExtraProfit: String = ""
    
    var advancedProfit: String = ""
    var advExtraProfit: String = ""
    
    var uppermostProfit: String = ""
    var upperExtraProfit: String = ""
    
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
        LoadingIndicator.showLoading()
        startParse()
        self.setRefreshControl()

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 2
        } else if section == 3 {
            return 2
        } else if section == 4 {
            return 3
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "고고학 재료 시세"
        } else if section == 1 {
            return "아래로 당겨서 순수익 계산 결과를 업데이트하세요"
        } else if section == 4 {
            return "제작 완료 알리미"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "아이템을 눌러 자세한 시세를 확인하세요"
        } else if section == 4 {
            return "알림센터에서 알림을 받기 위해서 'LoAssistant'의 알림 권한을 '허용'으로 설정해 주세요"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        let orehaCell = tableView.dequeueReusableCell(withIdentifier: "OrehaCell", for: indexPath) as! OrehaTableViewCell
        let resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
//        if firstLoad == true {
//            if indexPath.section == 0 {
//                let howToUseCell = tableView.dequeueReusableCell(withIdentifier: "HowToUseCell", for: indexPath) as! HowToUseTableViewCell
//                if indexPath.row == 0 {
//                    return howToUseCell
//                }
//                return howToUseCell
//            }
//        }
        
        if indexPath.section == 0 {
            ingredientCell.itemImage.image = UIImage(named: imageList[indexPath.row])
            ingredientCell.itemLabel.text = itemList[indexPath.row]
            if firstLoad == false {
                if indexPath.row == 0 {
                    ingredientCell.goldLabel.text = (self.ancient["Pricechart"].array![0]["Price"].stringValue) + " G"
                } else if indexPath.row == 1 {
                    ingredientCell.goldLabel.text = (self.rare["Pricechart"].array![0]["Price"].stringValue) + " G"
                } else if indexPath.row == 2 {
                    ingredientCell.goldLabel.text = (self.oreha["Pricechart"].array![0]["Price"].stringValue) + " G"
                }
            }
            return ingredientCell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                orehaCell.orehaImage.image = UIImage(named: imageList[3])
                orehaCell.orehaNameLabel.text = itemList[3]
                if firstLoad == false {
                    print("_____________________inter")
                    orehaCell.orehaPriceLabel.text = String(Int(get_intermediatePrice())) + " G"
                }
            return orehaCell
            }
            else {
                resultCell.profitPerCycle.text = intermediateProfit
                resultCell.extraProfit.text = interExtraProfit
                return resultCell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                orehaCell.orehaImage.image = UIImage(named: imageList[4])
                orehaCell.orehaNameLabel.text = itemList[4]
                if firstLoad == false {
                    print("_____________________adv")
                    orehaCell.orehaPriceLabel.text = String(Int(get_advancedPrice())) + " G"
                }
                return orehaCell
            }
            else {
                resultCell.profitPerCycle.text = advancedProfit
                resultCell.extraProfit.text = advExtraProfit
                return resultCell
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                orehaCell.orehaImage.image = UIImage(named: imageList[5])
                orehaCell.orehaNameLabel.text = itemList[5]
                if firstLoad == false {
                    print("_____________________upper")
                    orehaCell.orehaPriceLabel.text = String(Int(get_uppermostPrice())) + " G"
                }
                return orehaCell
            }
            else {
                resultCell.profitPerCycle.text = uppermostProfit
                resultCell.extraProfit.text = upperExtraProfit
                return resultCell
            }
        }
//        else if indexPath.section == 4 {
//            resultCell.interImage.image = UIImage(named: imageList[3])
//            resultCell.advImage.image = UIImage(named: imageList[4])
//            if firstLoad == false {
//                if indexPath.row == 0 {
//                    resultCell.interPrice.text = intermediateProfit
//                    resultCell.advPrice.text = advancedProfit
//                }
//            }
//            return resultCell
//        } else if indexPath.section == 5 {
//            resultCell.interImage.image = UIImage(named: imageList[3])
//            resultCell.advImage.image = UIImage(named: imageList[4])
//            if firstLoad == false {
//                if indexPath.row == 0 {
//                    resultCell.interPrice.text = interExtraProfit
//                    resultCell.advPrice.text = advExtraProfit
//                }
//            }
//            return resultCell
//        }
        else if indexPath.section == 4 {
            let timerCell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerTableViewCell
            var item = ""
            
            if indexPath.row == 0 {
                item = "중급"
            } else if indexPath.row == 1 {
                item = "상급"
            } else if indexPath.row == 2 {
                item = "최상급"
            }
            timerCell.timer?.invalidate()
            if UserDefaults.standard.bool(forKey: item + "타이머") == true {
                timerCell.remainedTimeLabel.textColor = UIColor.label
                timerCell.timeStateLabel.text = item + " 제작중"
                timerCell.expectedTime = UserDefaults.standard.object(forKey: item + "제작완료시간") as! Date?
                timerCell.timerButton.isSelected = true
                timerCell.timerButton.setTitle("타이머 초기화", for: .normal)
                timerCell.startTiemr(item: item)
            } else {
                timerCell.timerButton.setTitle(item + " 제작 시작", for: .normal)
                timerCell.remainedTimeLabel.text = getTimeTaken(item: item)
            }
            timerCell.item = item
            timerCell.expectedTimeStr = getTimeTaken(item: item)
            return timerCell
        }
        return ingredientCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !firstLoad {
            if indexPath.section == 0 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
                nextVC.isMaterial = true
                nextVC.ancient = ancient
                nextVC.rare = rare
                nextVC.oreha = oreha
                self.present(nextVC, animated: true)
            }

            if indexPath.row == 0 {
                if indexPath.section >= 1 && indexPath.section <= 3 {
                    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PriceTable") as? PriceTableViewController else {return}
                    nextVC.intermediate_oreha = intermediate_oreha
                    nextVC.advanced_oreha = advanced_oreha
                    nextVC.uppermost_oreha = uppermost_oreha
                    self.present(nextVC, animated: true)
                }
            }
        }
        
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                return nil
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 1 {
                return nil
            }
        } else if indexPath.section == 3 {
            if indexPath.row == 1 {
                return nil
            }
        } else if indexPath.section == 4 {
            return nil
        }
        return indexPath
    }
}

extension OrehaTableViewController {
    
    func startParse() {
        var counter =  0
        // 테이블뷰에 입력되는 데이터를 갱신한다.
        DispatchQueue.global().sync { [self] in
            print("_____________________refresh")
            parseMarketData(url: self.marketURL[0]) { (data) in
                self.ancient = data
                
                if data["Result"].stringValue == "Failed" {
                    let alert = UIAlertController(title: "오류 발생", message: data["Reason"].stringValue, preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                    self.tableView.refreshControl?.endRefreshing()
                } else {
                    self.parseMarketData(url: self.marketURL[1]) { (data) in
                        self.rare = data
                        counter += 1
                        print(data["Result"].stringValue)
                        
                        if counter == 5 {
                            print("-- start calculation --")
                            self.firstLoad = false
                            self.calculator()
                        }
                    }
                    self.parseMarketData(url: self.marketURL[2]) { (data) in
                        self.oreha = data
                        counter += 1
                        print(data["Result"].stringValue)
                        
                        if counter == 5 {
                            print("-- start calculation --")
                            self.firstLoad = false
                            self.calculator()
                        }
                    }
                    self.parseMarketData(url: self.marketURL[3]) { (data) in
                        self.intermediate_oreha = data
                        counter += 1
                        print(data["Result"].stringValue)
                        
                        if counter == 5 {
                            print("-- start calculation --")
                            self.firstLoad = false
                            self.calculator()
                        }
                    }
                    self.parseMarketData(url: self.marketURL[4]) { (data) in
                        self.advanced_oreha = data
                        counter += 1
                        print(data["Result"].stringValue)
                        
                        if counter == 5 {
                            print("-- start calculation --")
                            self.firstLoad = false
                            self.calculator()
                        }
                    }
                    self.parseMarketData(url: self.marketURL[5]) { (data) in
                        self.uppermost_oreha = data
                        counter += 1
                        print(data["Result"].stringValue)
                        print("-- 세팅 끝 --")
                        
                        if counter == 5 {
                            print("-- start calculation --")
                            self.firstLoad = false
                            self.calculator()
                        }
                    }
                }
            }
        }
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
        let uppermost_materialPrice = Int(trunc((get_ancientPrice()*1.07) + (get_rarePrice()*5.1) + (get_orehaPrice()*5.2)))
        
        let inter_cost = 200 * (100-reduction) / 100
        let advanced_cost = 250 * (100-reduction) / 100
        let uppermost_cost = 300 * (100-reduction) / 100
        
        var total_cost = inter_materialPrice + inter_cost
        intermediateProfit =  String((((get_interSalePrice()*30) - total_cost) * 10) * 제작슬롯) + " G"
        interExtraProfit = String(get_interSalePrice()*30) + " G"
        
        total_cost = advanced_materialPrice + advanced_cost
        advancedProfit =  String((((get_advSalePrice()*20) - total_cost) * 10) * 제작슬롯) + " G"
        advExtraProfit = String((get_advSalePrice()*20)) + " G"
        
        total_cost = uppermost_materialPrice + uppermost_cost
        print(total_cost)
        print(get_upperSalePrice()*15)
        uppermostProfit =  String((((get_upperSalePrice()*15) - total_cost) * 10) * 제작슬롯) + " G"
        print(uppermostProfit)
        upperExtraProfit = String((get_upperSalePrice()*15)) + " G"

        LoadingIndicator.hideLoading()
        tableView.refreshControl?.endRefreshing()
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
        var price: Double = 0.0
        let countOfItem = self.intermediate_oreha["Pricechart"].array!.count
        let standard = Int(truncating: UserDefaults.standard.float(forKey: "중급기준") as NSNumber) * 1000
        
        if countOfItem == 1 {
            price = Double(self.intermediate_oreha["Pricechart"].array![0]["Price"].stringValue)!
        } else {
            for i in 0...countOfItem-1 {
                let amount = self.intermediate_oreha["Pricechart"].array![i]["Amount"].stringValue.components(separatedBy: [","]).joined()
                if Int(amount)! >= standard {
                    price = Double(self.intermediate_oreha["Pricechart"].array![i]["Price"].stringValue)!
                    break
                }
            }
        }
        return price
    }
    func get_advancedPrice() -> Double {
        var price: Double = 0.0
        let countOfItem = self.advanced_oreha["Pricechart"].array!.count
        let standard = Int(truncating: UserDefaults.standard.float(forKey: "상급기준") as NSNumber) * 1000
        
        if countOfItem == 1 {
            price = Double(self.advanced_oreha["Pricechart"].array![0]["Price"].stringValue)!
        } else {
            for i in 0...countOfItem-1 {
                let amount = self.advanced_oreha["Pricechart"].array![i]["Amount"].stringValue.components(separatedBy: [","]).joined()
                if Int(amount)! >= standard {
                    price = Double(self.advanced_oreha["Pricechart"].array![i]["Price"].stringValue)!
                    break
                }
            }
        }
        return price
    }
    func get_uppermostPrice() -> Double {
        var price: Double = 0.0
        let countOfItem = self.uppermost_oreha["Pricechart"].array!.count
        let standard = Int(truncating: UserDefaults.standard.float(forKey: "최상급기준") as NSNumber) * 1000
        
        if countOfItem == 1 {
            price = Double(self.uppermost_oreha["Pricechart"].array![0]["Price"].stringValue)!
        } else {
            for i in 0...countOfItem-1 {
                let amount = self.uppermost_oreha["Pricechart"].array![i]["Amount"].stringValue.components(separatedBy: [","]).joined()
                if Int(amount)! >= standard {
                    price = Double(self.uppermost_oreha["Pricechart"].array![i]["Price"].stringValue)!
                    break
                }
            }
        }
        return price
    }
    func get_interSalePrice() -> Int {
        let commission = Int(ceil(get_intermediatePrice() * 0.05))
        return Int(get_intermediatePrice()) - commission
    }
    func get_advSalePrice() -> Int {
        let commission = Int(ceil(get_advancedPrice() * 0.05))
        return Int(get_advancedPrice()) - commission
    }
    func get_upperSalePrice() -> Int {
        let commission = Int(ceil(get_uppermostPrice() * 0.05))
        return Int(get_uppermostPrice()) - commission
    }
    
    func getTimeTaken(item: String) -> String {
        var reduction = 0.0
        
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "노동요") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "손놀림") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "자동기계") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "제작설계도") as NSNumber)
        let 제작공방 = Double(UserDefaults.standard.integer(forKey: "제작공방")/2)
        reduction += 제작공방 * 0.5
        
        if item == "중급" {
            let inter_time = Int(45 * 60 * (100-reduction) / 100) * 10
            let expectedTime = Date(timeIntervalSinceNow: TimeInterval(inter_time))
            let currentDate = Date()
            let secondsLeft = Int((expectedTime.timeIntervalSince(currentDate)))
            // 남은 시간
            let hours = secondsLeft / 60 / 60
            //남은 분
            let minutes = secondsLeft / 60 % 60
            //그러고도 남은 초
            let seconds = secondsLeft % 60 % 60
            
            return "\(hours)시간 \(minutes)분 \(seconds)초"
            
        } else if item == "상급" {
            let adv_time = Int(60 * 60 * (100-reduction) / 100) * 10
            let expectedTime = Date(timeIntervalSinceNow: TimeInterval(adv_time))
            let currentDate = Date()
            let secondsLeft = Int((expectedTime.timeIntervalSince(currentDate)))
            // 남은 시간
            let hours = secondsLeft / 60 / 60
            //남은 분
            let minutes = secondsLeft / 60 % 60
            //그러고도 남은 초
            let seconds = secondsLeft % 60 % 60
            
            return "\(hours)시간 \(minutes)분 \(seconds)초"
            
        } else if item == "최상급" {
            let adv_time = Int(75 * 60 * (100-reduction) / 100) * 10
            let expectedTime = Date(timeIntervalSinceNow: TimeInterval(adv_time))
            let currentDate = Date()
            let secondsLeft = Int((expectedTime.timeIntervalSince(currentDate)))
            // 남은 시간
            let hours = secondsLeft / 60 / 60
            //남은 분
            let minutes = secondsLeft / 60 % 60
            //그러고도 남은 초
            let seconds = secondsLeft % 60 % 60
            
            return "\(hours)시간 \(minutes)분 \(seconds)초"
        }
        return ""
    }
}

extension OrehaTableViewController {
    
    func setRefreshControl() {
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        
        startParse()
    }
}

