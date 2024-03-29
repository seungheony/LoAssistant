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
        if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                self.checkList = savedObject
            }
        }
        
        
        charName.delegate = self
        charName.text = UserDefaults.standard.string(forKey: "CharacterName")
        self.hideKeyboardWhenTappedAround()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            if indexPath.row == 1 {
                return indexPath
            }
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ExpeditionSetting") as? ExpeditionTableViewController else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                initializeCheckList()
                self.showAlert(title: "초기화 성공", message: "모든 캐릭터의 체크리스트가 초기화 되었습니다")
            }
            else if indexPath.row == 1 {
                guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CheckListSetting") as? CheckListSettingTableViewController else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    
    func initializeCheckList() {
        for i in 0...self.checkList.count-1 {
            self.checkList[i].argos = 0
            self.checkList[i].kayangel = 0
            
            self.checkList[i].valtan = 0
            self.checkList[i].biakiss = 0
            self.checkList[i].kouku_saton = 0
            self.checkList[i].abrelshud = 0
            self.checkList[i].illiakan = 0
            
            self.checkList[i].counter = 0
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.checkList) {
            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
        }
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
        getCharacterData()
        textField.resignFirstResponder()
        return true
    }
    func hideKeyboardWhenTappedAround() {
        if charName.text == "" {
            let tap = UITapGestureRecognizer(target: self, action: #selector(CharacterSettingTableViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func dismissKeyboard() {
        getCharacterData()
        view.endEditing(true)
    }
    
    func getCharacterData() {
        LoadingIndicator.showLoadingAtKeyBoard()
        if UserDefaults.standard.string(forKey: "CharacterName") != charName.text {
            let userInfoURL = "https://lostarkapi.ga/userinfo/" + charName.text!
            parseCaracterData(url: userInfoURL) { (data) in
                if data["Result"].stringValue == "Failed" {
                    let alert = UIAlertController(title: "오류", message: "원정대 데이터를 가져올 수 없습니다", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "확인", style: .default) { [self] (action) in
                        charName.text = UserDefaults.standard.string(forKey: "CharacterName")
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: false, completion: nil)
                    LoadingIndicator.hideLoading()
                } else {
                    // 캐릭터가 0개일 경우
                    if data["CharacterList"].count == 0 {
                        let alert = UIAlertController(title: "오류", message: "원정대 데이터를 가져올 수 없습니다", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "확인", style: .default) { [self] (action) in
                            charName.text = UserDefaults.standard.string(forKey: "CharacterName")
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: false, completion: nil)
                        LoadingIndicator.hideLoading()
                    }
                    else {
                        for i in 0...data["CharacterList"].count-1 {
                            let char_name = data["CharacterList"][i]["Name"].stringValue
                            
                            let levelString = data["CharacterList"][i]["Level"].stringValue
                            let startIdx:String.Index = levelString.index(levelString.startIndex, offsetBy: 3)
                            let char_level: Float = Float(levelString[startIdx...].components(separatedBy: [","]).joined())!
                            
                            let char_class = data["CharacterList"][i]["Class"].stringValue
                            
                            let list: CheckList = CheckList(earnGold: false, counter: 0, char_name: char_name, char_level: char_level, char_class: char_class, argos: 0, valtan: 0, biakiss: 0, kouku_saton: 0, kayangel: 0, abrelshud: 0, illiakan: 0)
                            self.checkList.append(list)
                        }
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(self.checkList) {
                            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
                        }
                        UserDefaults.standard.set(self.charName.text, forKey: "CharacterName")
                        
                        LoadingIndicator.hideLoading()
                    }
                }
            }
        } else {
            // 저장된 이름과 같은 경우
            LoadingIndicator.hideLoading()
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            // action
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
}
