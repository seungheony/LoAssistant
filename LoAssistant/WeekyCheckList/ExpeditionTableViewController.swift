//
//  ExpeditionTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/23.
//

import UIKit

class ExpeditionTableViewController: UITableViewController {

    var checkList: [CheckList] = []
    
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
        cell.charClassImage.image = UIImage(named: self.checkList[indexPath.row].char_class + ".png")
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            
            if self.checkList[indexPath.row].changeability == true {
                let alert = UIAlertController(title: "체크 해제 불가", message: "이 캐릭터는 이미 골드 획득을 완료했습니다\n체크리스트를 확인해 주세요", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            
                }
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
                
            } else {
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    // 체크 해제
                    self.checkList[indexPath.row].earnGold = false
                } else {
                    cell.accessoryType = .checkmark
                    // 체크
                    self.checkList[indexPath.row].earnGold = true
                }
            }
            
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

}
