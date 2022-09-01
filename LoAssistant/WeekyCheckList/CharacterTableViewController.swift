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

        return self.checkList.count * 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let level = self.checkList[section/2].char_level
        
        // 군단장
        if section % 2 == 0 {
            if level >= 1600 {
                return 6
            } else if level >= 1580 {
                return 6
            } else if level >= 1560 {
                return 5
            } else if level >= 1550 {
                return 5
            } else if level >= 1540 {
                return 5
            } else if level >= 1520 {
                return 5
            } else if level >= 1500 {
                return 5
            } else if level >= 1490 {
                return 5
            } else if level >= 1475 {
                return 4
            } else if level >= 1460 {
                return 3
            } else if level >= 1445 {
                return 3
            } else if level >= 1430 {
                return 3
            } else if level >= 1415 {
                return 2
            }
        // 어비스
        } else {
            if level >= 1600 {
                return 2
            } else if level >= 1580 {
                return 2
            } else if level >= 1560 {
                return 2
            } else if level >= 1550 {
                return 2
            } else if level >= 1540 {
                return 2
            } else if level >= 1520 {
                return 2
            } else if level >= 1500 {
                return 2
            } else if level >= 1490 {
                return 2
            } else if level >= 1475 {
                return 2
            } else if level >= 1460 {
                return 1
            } else if level >= 1445 {
                return 1
            } else if level >= 1430 {
                return 1
            } else if level >= 1415 {
                return 1
            }
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let InfoCell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoTableViewCell
        if indexPath.section % 2 == 0 {
            if indexPath.row == 0 {
                InfoCell.charNameLabel.text = self.checkList[indexPath.section/2].char_name
                
                InfoCell.charLevelLabel.text = "Lv." + String(self.checkList[indexPath.section/2].char_level)
                
                let className: String = getEngClassName(kor: self.checkList[indexPath.section/2].char_class)
                InfoCell.charClassImage.image = UIImage(named: className)
                
                if self.checkList[indexPath.section/2].earnGold == true {
                    InfoCell.charNameLabel.textColor = UIColor.link
                }
                return InfoCell
            }
        }
        return setCheckListCell(index: indexPath)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        let day = UserDefaults.standard.string(forKey: "InitializeDay")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월dd일 HH시mm분ss초"
        dateFormatter.locale = Locale(identifier: "ko")
        
        let date = dateFormatter.date(from: day ?? "1998년12월17일 00시00분00초")
        
        print("is past? : \(Date().isPast(fromDate: date ?? Date()))")
        if Date().isPast(fromDate: date ?? Date()) && checkList.count >= 1 {
            for i in 0...checkList.count-1 {
                checkList[i].argos = false
                checkList[i].kayangel = 0
                
                checkList[i].valtan = false
                checkList[i].biakiss = false
                checkList[i].kouku_saton = false
                checkList[i].abrelshud = 0
                checkList[i].illiakan = false
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.checkList) {
                UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
            }
            print(self.checkList)
        }
        
        
        if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                self.checkList = savedObject
            }
        }
        self.tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
        set_initializeCheckList()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.checkList) {
            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
    func setCheckListCell(index: IndexPath) -> UITableViewCell {
        let level = self.checkList[index.section/2].char_level
        // 군단장
        if index.section % 2 == 0 {
            if level >= 1600 {
                if index.row == 1 {
                    return get_illiakanCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 3 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 4 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 5 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1580 {
                if index.row == 1 {
                    return get_illiakanCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 3 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 4 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 5 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1560 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1550 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1540 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1520 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1500 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1490 {
                if index.row == 1 {
                    return get_abrelshudCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 3 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 4 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1475 {
                if index.row == 1 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 2 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 3 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1460 {
                if index.row == 1 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1445 {
                if index.row == 1 {
                    return get_valtanCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_biackissCell(level: level, index: index)
                }
            } else if level >= 1430 {
                if index.row == 1 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1415 {
                if index.row == 1 {
                    return get_valtanCell(level: level, index: index)
                }
            }
        // 어비스
        } else {
            if level >= 1580 {
                if index.row == 0 {
                    return get_kayangelCell(level: level, index: index)
                } else if index.row == 1 {
                    return get_argosCell(index: index)
                }
            } else if level >= 1560 {
                if index.row == 0 {
                    return get_kayangelCell(level: level, index: index)
                } else if index.row == 1 {
                    return get_argosCell(index: index)
                }
            } else if level >= 1520 {
                if index.row == 0 {
                    return get_kayangelCell(level: level, index: index)
                } else if index.row == 1 {
                    return get_argosCell(index: index)
                }
            } else if level >= 1475 {
                if index.row == 0 {
                    return get_kayangelCell(level: level, index: index)
                } else if index.row == 1 {
                    return get_argosCell(index: index)
                }
            } else if level >= 1370 {
                if index.row == 0 {
                    return get_argosCell(index: index)
                }
            }
        }
        return UITableViewCell()
    }
    
    func get_illiakanCell(level: Float, index: IndexPath) -> IlliakanTableViewCell {
        let illiakanCell = tableView.dequeueReusableCell(withIdentifier: "IlliakanCell", for: index) as! IlliakanTableViewCell
        illiakanCell.level = level
        illiakanCell.charIndex = index.section/2
        illiakanCell.delegate = self
        
        print("illiakan is Selected : \(illiakanCell.gate1Button.isSelected)")
        
        illiakanCell.gate1Button.isSelected = false
        if self.checkList[index.section/2].illiakan == true {
            illiakanCell.gate1Button.isSelected = true
        }
        
        illiakanCell.gate1Button.isEnabled = true
        if illiakanCell.gate1Button.isSelected == false {
            print("illiakan is not Selected")
            if self.checkList[index.section/2].counter == 3 {
                illiakanCell.gate1Button.isEnabled = false
            } else if self.checkList[index.section/2].counter == 2 {
                illiakanCell.gate1Button.isEnabled = true
            }
        }
        
        if level >= 1600 {
            illiakanCell.raidNameLabel.attributedText = illiakanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            illiakanCell.raidNameLabel.attributedText = illiakanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return illiakanCell
    }
    func get_abrelshudCell(level: Float, index: IndexPath) -> AbrelshudTableViewCell {
        let abrelshudCell = tableView.dequeueReusableCell(withIdentifier: "Abrelshud_12Cell", for: index) as! AbrelshudTableViewCell
        abrelshudCell.level = level
        abrelshudCell.charIndex = index.section/2
        abrelshudCell.delegate = self
        
        abrelshudCell.gate12Button.isSelected = false
        abrelshudCell.gate34Button.isSelected = false
        abrelshudCell.gate56Button.isSelected = false
        
        print(self.checkList[index.section/2].abrelshud)
        if self.checkList[index.section/2].abrelshud >= 1 {
            print(self.checkList[index.section/2].abrelshud)
            abrelshudCell.gate12Button.isSelected = true
            if self.checkList[index.section/2].abrelshud >= 2 {
                abrelshudCell.gate34Button.isSelected = true
                if self.checkList[index.section/2].abrelshud == 3 {
                    abrelshudCell.gate56Button.isSelected = true
                }
            }
        }
        
        abrelshudCell.gate12Button.isEnabled = true
        abrelshudCell.gate34Button.isEnabled = true
        abrelshudCell.gate56Button.isEnabled = true
        
        if abrelshudCell.gate12Button.isSelected == false {
            if self.checkList[index.section/2].counter == 3 {
                abrelshudCell.gate12Button.isEnabled = false
                abrelshudCell.gate34Button.isEnabled = false
                abrelshudCell.gate56Button.isEnabled = false
            } else if self.checkList[index.section/2].counter == 2 {
                abrelshudCell.gate12Button.isEnabled = true
                abrelshudCell.gate34Button.isEnabled = true
                abrelshudCell.gate56Button.isEnabled = true
            }
        }
        
        if level >= 1540 {
            abrelshudCell.raidNameLabel.attributedText = abrelshudCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            abrelshudCell.raidNameLabel.attributedText = abrelshudCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return abrelshudCell
    }
    func get_kouku_satonCell(index: IndexPath) -> Kouku_SatonTableViewCell {
        let kouku_satonCell = tableView.dequeueReusableCell(withIdentifier: "Kouku_SatonCell", for: index) as! Kouku_SatonTableViewCell
        kouku_satonCell.charIndex = index.section/2
        kouku_satonCell.delegate = self
        
        kouku_satonCell.gate1Button.isSelected = false
        if self.checkList[index.section/2].kouku_saton == true {
            kouku_satonCell.gate1Button.isSelected = true
        }
        
        kouku_satonCell.gate1Button.isEnabled = true
        if kouku_satonCell.gate1Button.isSelected == false {
            if self.checkList[index.section/2].counter == 3 {
                kouku_satonCell.gate1Button.isEnabled = false
            } else if self.checkList[index.section/2].counter == 2 {
                kouku_satonCell.gate1Button.isEnabled = true
            }
        }
        
        return kouku_satonCell
    }
    func get_biackissCell(level: Float, index: IndexPath) -> BiackissTableViewCell {
        let biakissCell = tableView.dequeueReusableCell(withIdentifier: "BiackissCell", for: index) as! BiackissTableViewCell
        biakissCell.level = level
        biakissCell.charIndex = index.section/2
        biakissCell.delegate = self
        
        biakissCell.gate1Button.isSelected = false
        if self.checkList[index.section/2].biakiss == true {
            biakissCell.gate1Button.isSelected = true
        }
        
        biakissCell.gate1Button.isEnabled = true
        if biakissCell.gate1Button.isSelected == false {
            if self.checkList[index.section/2].counter == 3 {
                biakissCell.gate1Button.isEnabled = false
            } else if self.checkList[index.section/2].counter == 2 {
                biakissCell.gate1Button.isEnabled = true
            }
        }
        
        if level >= 1460 {
            biakissCell.raidNameLabel.attributedText = biakissCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            biakissCell.raidNameLabel.attributedText = biakissCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return biakissCell
    }
    func get_valtanCell(level: Float, index: IndexPath) -> ValtanTableViewCell {
        let valtanCell = tableView.dequeueReusableCell(withIdentifier: "ValtanCell", for: index) as! ValtanTableViewCell
        valtanCell.level = level
        valtanCell.charIndex = index.section/2
        valtanCell.delegate = self
        
        valtanCell.gate1Button.isSelected = false
        if self.checkList[index.section/2].valtan == true {
            valtanCell.gate1Button.isSelected = true
        }
        
        valtanCell.gate1Button.isEnabled = true
        if valtanCell.gate1Button.isSelected == false {
            if self.checkList[index.section/2].counter == 3 {
                valtanCell.gate1Button.isEnabled = false
            } else if self.checkList[index.section/2].counter == 2 {
                valtanCell.gate1Button.isEnabled = true
            }
        }
        
        if level >= 1445 {
            valtanCell.raidNameLabel.attributedText = valtanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            valtanCell.raidNameLabel.attributedText = valtanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return valtanCell
    }
    
    func get_kayangelCell(level: Float, index: IndexPath) -> KayangelTableViewCell {
        let kayangelCell = tableView.dequeueReusableCell(withIdentifier: "KayangelCell", for: index) as! KayangelTableViewCell
        kayangelCell.level = level
        kayangelCell.charIndex = index.section/2
        kayangelCell.delegate = self
        
        kayangelCell.gate1Button.isSelected = false
        kayangelCell.gate2Button.isSelected = false
        
        if self.checkList[index.section/2].kayangel >= 1 {
            kayangelCell.gate1Button.isSelected = true
            if self.checkList[index.section/2].kayangel == 2 {
                kayangelCell.gate2Button.isSelected = true
            }
        }
        
        if level >= 1580 {
            kayangelCell.raidNameLabel.attributedText = kayangelCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드-3")
        } else if level >= 1560 {
            kayangelCell.raidNameLabel.attributedText = kayangelCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드-2")
        } else if level >= 1520 {
            kayangelCell.raidNameLabel.attributedText = kayangelCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드-1")
        } else {
            kayangelCell.raidNameLabel.attributedText = kayangelCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return kayangelCell
    }
    func get_argosCell(index: IndexPath) -> ArgosTableViewCell {
        let argosCell = tableView.dequeueReusableCell(withIdentifier: "ArgosCell", for: index) as! ArgosTableViewCell
        argosCell.charIndex = index.section/2
        argosCell.delegate = self
        
        argosCell.checkButton.isSelected = false
        if self.checkList[index.section/2].argos == true {
            argosCell.checkButton.isSelected = true
        }
        
        return argosCell
    }
    
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
    
    func set_initializeCheckList() {
        var today = Date()
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "E"
        let day_of_the_week = dateFormatter.string(from: today)
        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: today))
        
        if (day_of_the_week == "수") && (hour! < 6) {
            // 당일 오전 6시로 설정
            dateFormatter.dateFormat = "yyyy년MM월dd일 06시00분00초"
            let day = dateFormatter.string(from: today)
            UserDefaults.standard.setValue(day, forKey: "InitializeDay")
            
        } else {
            while true {
                
                today = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? Date()
                dateFormatter.dateFormat = "E"
                if dateFormatter.string(from: today) == "수" {
                    dateFormatter.dateFormat = "yyyy년MM월dd일 06시00분00초"
                    let day = dateFormatter.string(from: today)
                    print(day)
                    UserDefaults.standard.setValue(day, forKey: "InitializeDay")
                    break
                }
            }
        }
    }
}
extension CharacterTableViewController: CheckButtonTappedDelegate {
    func checkButtonTapped(gateNum: Int, raidName: String, charIndex: Int) {
        
        self.checkList[charIndex].counter = 0
        
        var isChecked: Bool = false
        if gateNum >= 1 {
            isChecked = true
        }
        
        if raidName.contains("아르고스") {
            self.checkList[charIndex].argos = isChecked
        } else if raidName.contains("카양겔") {
            self.checkList[charIndex].kayangel = gateNum
        } else if raidName.contains("일리아칸") {
            self.checkList[charIndex].illiakan = isChecked
        } else if raidName.contains("아브렐슈드") {
            self.checkList[charIndex].abrelshud = gateNum
        } else if raidName.contains("쿠크세이튼") {
            self.checkList[charIndex].kouku_saton = isChecked
        } else if raidName.contains("비아키스") {
            self.checkList[charIndex].biakiss = isChecked
        } else if raidName.contains("발탄") {
            self.checkList[charIndex].valtan = isChecked
        }
        
        if self.checkList[charIndex].illiakan == true {
            self.checkList[charIndex].counter += 1
        }
        if self.checkList[charIndex].abrelshud >= 1 {
            self.checkList[charIndex].counter += 1
        }
        if self.checkList[charIndex].kouku_saton == true {
            self.checkList[charIndex].counter += 1
        }
        if self.checkList[charIndex].biakiss == true {
            self.checkList[charIndex].counter += 1
        }
        if self.checkList[charIndex].valtan == true {
            self.checkList[charIndex].counter += 1
        }
        
        if self.checkList[charIndex].counter >= 2 {
            self.tableView.reloadData()
        }
        print("counter = \(self.checkList[charIndex].counter)")
        print("index: \(charIndex)")
        print(self.checkList)
    }
}
