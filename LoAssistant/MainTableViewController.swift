//
//  MainTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var crystalPrice: UILabel!
    var crystalJSON: JSON?
    var crystal: Double = 0
    let crystalURL = "https://lostarkapi.ga/crystal/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingHUD.show()
        parseCrystalData(url: crystalURL) { (data) in
            if data["Result"].stringValue == "Failed" {
                self.crystalPrice.text = "Error"
            } else {
                self.crystalJSON = data
                self.crystalPrice.text = self.crystalJSON!["Buy"].stringValue + " G"
                self.crystal = Double(self.crystalJSON!["Buy"].stringValue)!
            }
            LoadingHUD.hide()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PheonView") as? PheonViewController else {
                    return
                }
                if crystal == 0.0 {
                    let alert = UIAlertController(title: "오류 발생", message: "크리스탈 데이터를 가져올 수 없습니다", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                } else {
                    nextVC.crystal = self.crystal
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
            else if indexPath.row == 1 {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrehaTable") else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Character Table") as? CharacterTableViewController else {
                    return
                }
                self.navigationController?.pushViewController(uvc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return nil
            }
        }
        return indexPath
    }
}


