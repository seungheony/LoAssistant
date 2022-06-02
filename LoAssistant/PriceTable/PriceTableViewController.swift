//
//  PriceTableViewController.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/06/02.
//

import UIKit

class PriceTableViewController: UITableViewController {

    var isMaterial: Bool = false
    
    var ancient = [Pricechart]()
    var rare = [Pricechart]()
    var oreha = [Pricechart]()
    
    var intermediate_oreha = [Pricechart]()
    var advanced_oreha = [Pricechart]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if isMaterial == true {
            return 4
        } else if isMaterial == false {
            return 3
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
                return ancient.count
            }
            if section == 2 {
                return rare.count
            }
            if section == 3 {
                return oreha.count
            }
            
        } else if isMaterial == false {
            if section == 0 {
                return 0
            }
            if section == 1 {
                return intermediate_oreha.count
            }
            if section == 2 {
                return advanced_oreha.count
            }
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PriceTableViewCell

        // Configure the cell...
        if isMaterial == true {
            if indexPath.section == 1 {
                cell.amountLabel.text = ancient[indexPath.row].amount!
                cell.priceLabel.text = ancient[indexPath.row].price! + "G"
            }
            if indexPath.section == 2 {
                cell.amountLabel.text = rare[indexPath.row].amount!
                cell.priceLabel.text = rare[indexPath.row].price! + "G"
            }
            if indexPath.section == 3 {
                cell.amountLabel.text = oreha[indexPath.row].amount!
                cell.priceLabel.text = oreha[indexPath.row].price! + "G"
            }
        }
        else if isMaterial == false {
            if indexPath.section == 1 {
                cell.amountLabel.text = intermediate_oreha[indexPath.row].amount!
                cell.priceLabel.text = intermediate_oreha[indexPath.row].price! + "G"
            }
            if indexPath.section == 2 {
                cell.amountLabel.text = advanced_oreha[indexPath.row].amount!
                cell.priceLabel.text = advanced_oreha[indexPath.row].price! + "G"
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
            }
        }
        return ""
    }
}
