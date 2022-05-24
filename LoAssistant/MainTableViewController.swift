//
//  MainTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/25.
//

import UIKit

class MainTableViewController: UITableViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
                return
            }
            self.navigationController?.pushViewController(uvc, animated: true)
        }
        else if indexPath.row == 1 {
            
        }
    }
}
