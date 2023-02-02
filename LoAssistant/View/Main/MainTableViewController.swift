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
    
    override func viewWillAppear(_ animated: Bool) {
        // 각 상황별로 실행할 작업을 클로저 내에 작성
        checkAppFirstrunOrUpdateStatus {
            // 앱 설치 후 최초 실행할때만 실행됨
        } updated: {
            // 버전 변경시마다 실행됨
//            updateAlert(message: "업데이트 내역 테스트입니다. ")
        } nothingChanged: {
            // 변경 사항 없음
        }
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
    
    func checkAppFirstrunOrUpdateStatus(firstrun: () -> (), updated: () -> (), nothingChanged: () -> ()) {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let versionOfLastRun = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
        // print(#function, currentVersion ?? "", versionOfLastRun ?? "")
        if versionOfLastRun == nil {
            // First start after installing the app
            firstrun()
        } else if versionOfLastRun != currentVersion {
            // App was updated since last run
            updated()
        } else {
            // nothing changed
            nothingChanged()
        }
        UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
        UserDefaults.standard.synchronize()
    }
    
    func updateAlert(message: String) {
        let alert = UIAlertController(title: "업데이트 내역", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            // ok Action
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
}


