//
//  MainTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/25.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var crystalPrice: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parseData(url: "http://152.70.248.4:5000/crystal/")
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PheonView") else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            else if indexPath.row == 2 {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrehaTable") else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
//                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "OrehaTableTest") else {
//                    return
//                }
//                self.navigationController?.pushViewController(uvc, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return nil
            }
            return indexPath
        }
        return indexPath
    }
}

extension MainTableViewController {
    func parseData(url: String) {
        GetCrystalDataService.shared.getCrystalInfo(URL: url) { (response) in
            // NetworkResult형 enum값을 이용해서 분기처리를 합니다.
            switch(response) {
            
            // 성공할 경우에는 <T>형으로 데이터를 받아올 수 있다고 했기 때문에 Generic하게 아무 타입이나 가능하기 때문에
            // 클로저에서 넘어오는 데이터를 let personData라고 정의합니다.
            case .success(let crystalData):
                // personData를 Person형이라고 옵셔널 바인딩 해주고, 정상적으로 값을 data에 담아둡니다.
                self.crystalPrice.text = crystalData + " G"
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
