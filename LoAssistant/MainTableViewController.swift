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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrehaTable") else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else if indexPath.row == 1 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PheonView") as? PheonViewController else {
                    return
                }
                nextVC.crystal = self.crystal
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Character Table") else {
                    return
                }
                self.navigationController?.pushViewController(uvc, animated: true)
            }
        }
    }
}


