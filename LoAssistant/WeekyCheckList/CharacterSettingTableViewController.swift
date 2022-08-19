//
//  CharacterSettingTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/18.
//

import UIKit
import SwiftyJSON

class CharacterSettingTableViewController: UITableViewController, UITextFieldDelegate {
    
    var checkList: [CheckList] = []

    @IBOutlet weak var charName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        charName.delegate = self
        charName.text = UserDefaults.standard.string(forKey: "CharacterName")
        self.hideKeyboardWhenTappedAround()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func dataParseBtn(_ sender: Any) {
        LoadingHUD.show()
        if UserDefaults.standard.string(forKey: "CharacterName") == charName.text {
            // 체크리스트 구조체 업데이트
            LoadingHUD.hide()
        } else {
            // 체크리스트 구조체 생성
            let userInfoURL = "https://lostarkapi.ga/userinfo/" + charName.text!
            parseCaracterData(url: userInfoURL) { (data) in
                if data["Result"].stringValue == "Failed" {
                    print(data["Reason"].stringValue);
                } else {
                    print(data["CharacterList"].count)
                    for i in 0...data["CharacterList"].count-1 {
                        let char_name = data["CharacterList"][i]["Name"].stringValue
                        
                        let levelString = data["CharacterList"][i]["Level"].stringValue
                        let startIdx:String.Index = levelString.index(levelString.startIndex, offsetBy: 3)
                        let char_level: Float = Float(levelString[startIdx...].components(separatedBy: [","]).joined())!
                        
                        let char_class = data["CharacterList"][i]["Class"].stringValue
                        
                        let list: CheckList = CheckList(char_name: char_name, char_level: char_level, char_class: char_class, 아르고스: false, 발탄노말: false, 비아키스노말: false, 발탄하드: false, 비아키스하드: false, 쿠크세이튼: false, 카양겔노말: false, 아브12노말: false, 아브34노말: false, 아브56노말: false, 카양겔하드1: false, 아브12하드: false, 아브34하드: false, 아브56하드: false, 카양겔하드2: false, 카양겔하드3: false)
                        self.checkList.append(list)
                    }
                    print(self.checkList)
                    
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(self.checkList) {
                        UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
                    }
                    LoadingHUD.hide()
                    UserDefaults.standard.set(self.charName.text, forKey: "CharacterName")
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            return nil
        }
        return indexPath
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CharacterSettingTableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
