//
//  PriceTableViewController.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/06/02.
//

import UIKit
import SwiftyJSON

class PriceTableViewController: UITableViewController {

    var isMaterial: Bool = false
    
    var ancient = JSON()
    var rare = JSON()
    var oreha = JSON()
    
    var intermediate_oreha = JSON()
    var advanced_oreha = JSON()
    var uppermost_oreha = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if isMaterial == true {
            return 4
        } else if isMaterial == false {
            return 4
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isMaterial == true {
            if section == 0 {
                return 0
            }
            if section == 1 {
                return ancient["Pricechart"].array!.count
            }
            if section == 2 {
                return rare["Pricechart"].array!.count
            }
            if section == 3 {
                return oreha["Pricechart"].array!.count
            }
            
        } else if isMaterial == false {
            if section == 0 {
                return 0
            }
            if section == 1 {
                return intermediate_oreha["Pricechart"].array!.count
            }
            if section == 2 {
                return advanced_oreha["Pricechart"].array!.count
            }
            if section == 3 {
                return uppermost_oreha["Pricechart"].array!.count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PriceTableViewCell
        // Configure the cell...
        if isMaterial == true {
            if indexPath.section == 1 {
                cell.amountLabel.text = ancient["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = ancient["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
            if indexPath.section == 2 {
                cell.amountLabel.text = rare["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = rare["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
            if indexPath.section == 3 {
                cell.amountLabel.text = oreha["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = oreha["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
        }
        else if isMaterial == false {
            if indexPath.section == 1 {
                cell.amountLabel.text = intermediate_oreha["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = intermediate_oreha["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
            if indexPath.section == 2 {
                cell.amountLabel.text = advanced_oreha["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = advanced_oreha["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
            if indexPath.section == 3 {
                cell.amountLabel.text = uppermost_oreha["Pricechart"].array![indexPath.row]["Amount"].stringValue
                cell.priceLabel.text = uppermost_oreha["Pricechart"].array![indexPath.row]["Price"].stringValue + "G"
            }
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isMaterial == true {
            if section == 1 {
                return "고대 유물 [100개 단위]"
            } else if section == 2 {
                return "희귀한 유물 [10개 단위]"
            } else if section == 3 {
                return "오레하 유물 [10개 단위]"
            }
        }
        if isMaterial == false {
            if section == 1 {
                return "중급 오레하 융화 재료"
            } else if section == 2 {
                return "상급 오레하 융화 재료"
            } else if section == 3 {
                return "최상급 오레하 융화 재료"
            }
        }
        return ""
    }
}
