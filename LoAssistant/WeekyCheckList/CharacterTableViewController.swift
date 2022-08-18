//
//  CharacterTableViewController.swift
//  LoAssistant
//
//  Created by shkim on 2022/08/11.
//

import UIKit
import SwiftyJSON

class CharacterTableViewController: UITableViewController {
    
    var characterList = JSON()
    var userInfoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        let data = JSON(UserDefaults.standard.object(forKey: "체크리스트"))
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let data = JSON(UserDefaults.standard.object(forKey: "체크리스트"))
//        let level = Float(data[section]["Level"].stringValue.index(after: 3))
//        print(data[section]["Level"].stringValue)
        
        let levelString = data[section]["Level"].stringValue
        let startIdx:String.Index = levelString.index(levelString.startIndex, offsetBy: 3)
        print(levelString[startIdx...])
        
        let level: Float = Float(levelString[startIdx...].components(separatedBy: [","]).joined())!
        if level >= 1415 {
            if level >= 1430 {
                if level >= 1445 {
                    if level >= 1460 {
                        if level >= 1475 {
                            return 3
                        }
                        return 2
                    }
                    return 2
                }
                return 2
            }
            return 1
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let InfoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableViewCell
        let CheckCell = tableView.dequeueReusableCell(withIdentifier: "CheckListCell", for: indexPath) as? CheckListTableViewCell
        if indexPath.row == 0 {
            let charName: String = JSON(UserDefaults.standard.object(forKey: "체크리스트"))[indexPath.section]["Name"].stringValue
            InfoCell!.charNameLabel.text = charName
            return InfoCell!
        }
        return CheckCell!
    }

    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        self.tableView.reloadData()
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
