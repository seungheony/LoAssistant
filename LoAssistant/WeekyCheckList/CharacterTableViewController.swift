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
        userInfoURL = "https://lostarkapi.ga/userinfo/" + UserDefaults.standard.string(forKey: "캐릭터")!
        parseCaracterData(url: userInfoURL!) { (data) in
            if data["Result"].stringValue == "Failed" {
                print(data["Reason"].stringValue);
            } else {
                self.characterList = data
                print(data["CharacterList"])
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoTableViewCell
        cell!.charNameLabel.text = UserDefaults.standard.string(forKey: "캐릭터")!
        return cell!
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
