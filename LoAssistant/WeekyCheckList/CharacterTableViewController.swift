//
//  CharacterTableViewController.swift
//  LoAssistant
//
//  Created by shkim on 2022/08/11.
//

import UIKit
import SwiftyJSON

class CharacterTableViewController: UITableViewController {
    
    var checkList: [CheckList] = [CheckList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                self.checkList = savedObject
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func settingBtn(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "CharacterSetting") as? CharacterSettingTableViewController else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections

        return self.checkList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let level = self.checkList[section].char_level
        
        if level >= 1490 {
            return 6
        } else if level >= 1475 {
            return 6
        } else if level >= 1430 {
            return 4
        } else if level >= 1415 {
            return 3
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let InfoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableViewCell
        let CheckCell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as? CheckListTableViewCell
        if indexPath.row == 0 {
            InfoCell!.charNameLabel.text = self.checkList[indexPath.section].char_name
            InfoCell!.charLevelLabel.text = "Lv." + String(self.checkList[indexPath.section].char_level)
            let className: String = getEngClassName(kor: self.checkList[indexPath.section].char_class)
            InfoCell!.charClassImage.image = UIImage(named: className)
            return InfoCell!
        }
        
        return CheckCell!
    }

    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                self.checkList = savedObject
            }
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getEngClassName(kor: String) -> String {
        if kor == "기상술사" {
            return "aeromancer"
        } else if kor == "아르카나" {
            return "arcana"
        } else if kor == "블래스터" {
            return "artillerist"
        } else if kor == "도화가" {
            return "artist"
        } else if kor == "바드" {
            return "bard"
        } else if kor == "버서커" {
            return "berserker"
        } else if kor == "데빌헌터" {
            return "deadeye"
        } else if kor == "블레이드" {
            return "deathblade"
        } else if kor == "디스트로이어" {
            return "destroyer"
        } else if kor == "창술사" {
            return "glaivier"
        } else if kor == "워로드" {
            return "gunlancer"
        } else if kor == "건슬링어" {
            return "gunslinger"
        } else if kor == "홀리나이트" {
            return "paladin"
        } else if kor == "리퍼" {
            return "reaper"
        } else if kor == "스카우터" {
            return "scouter"
        } else if kor == "인파이터" {
            return "scrapper"
        } else if kor == "데모닉" {
            return "shadowhunter"
        } else if kor == "호크아이" {
            return "sharpshooter"
        } else if kor == "소서리스" {
            return "sorceress"
        } else if kor == "기공사" {
            return "soulfist"
        } else if kor == "스트라이커" {
            return "striker"
        } else if kor == "서머너" {
            return "summoner"
        } else if kor == "배틀마스터" {
            return "wardancer"
        }
        return ""
    }
}
