//
//  ExpeditionTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/23.
//

import UIKit

class ExpeditionTableViewController: UITableViewController {

    var checkList: [CheckList] = []
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                self.checkList = savedObject
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ExpeditionTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expeditionCell", for: indexPath) as! ExpeditionTableViewCell
        cell.charNameLabel.text = self.checkList[indexPath.row].char_name
//        cell.charLevelLabel.text = "Lv." + String(self.checkList[indexPath.section].char_level)
        let className: String = getEngClassName(kor: self.checkList[indexPath.row].char_class)
        cell.charClassImage.image = UIImage(named: className)
        
        if self.checkList[indexPath.row].earnGold == true {
            counter += 1
            cell.accessoryType = .checkmark
            cell.charNameLabel.textColor = UIColor.link
            print(counter)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) as? ExpeditionTableViewCell {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                // 체크 해제
                counter -= 1
                cell.charNameLabel.textColor = UIColor.label
                self.checkList[indexPath.row].earnGold = false
            } else {
                // 체크
                if counter == 6 {
                    let alert = UIAlertController(title: "더 이상 추가할 수 없습니다", message: "골드 획득은 최대 6 캐릭터만 가능합니다", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                } else {
                    counter += 1
                    cell.accessoryType = .checkmark
                    cell.charNameLabel.textColor = UIColor.link
                    self.checkList[indexPath.row].earnGold = true
                }
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.checkList) {
                UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
            }
//            if self.checkList[indexPath.row].changeability == true {
//                let alert = UIAlertController(title: "체크 해제 불가", message: "이 캐릭터는 이미 골드 획득을 완료했습니다\n체크리스트를 확인해 주세요", preferredStyle: UIAlertController.Style.alert)
//                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//
//                }
//                alert.addAction(okAction)
//                self.present(alert, animated: false, completion: nil)
//
//            } else {
//                if cell.accessoryType == .checkmark {
//                    cell.accessoryType = .none
//                    // 체크 해제
//                    self.checkList[indexPath.row].earnGold = false
//                } else {
//                    cell.accessoryType = .checkmark
//                    // 체크
//                    self.checkList[indexPath.row].earnGold = true
//                }
//            }
            
        }
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
