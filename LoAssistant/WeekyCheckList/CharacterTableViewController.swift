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
                return 8
            } else if level >= 1580 {
                return 8
            } else if level >= 1560 {
                return 7
            } else if level >= 1550 {
                return 7
            } else if level >= 1540 {
                return 7
            } else if level >= 1520 {
                return 7
            } else if level >= 1500 {
                return 6
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
    func setCheckListCell(index: IndexPath) -> UITableViewCell {
        let level = self.checkList[index.section/2].char_level
        // 군단장
        if index.section % 2 == 0 {
            if level >= 1600 {
                if index.row == 1 {
                    return get_illiakanCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 5 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 6 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 7 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1580 {
                if index.row == 1 {
                    return get_illiakanCell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 5 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 6 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 7 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1560 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 5 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 6 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1550 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 5 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 6 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1540 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 5 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 6 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1520 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_abrelshud_56Cell(level: level, index: index)
                } else if index.row == 4 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 5 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 6 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1500 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
                } else if index.row == 2 {
                    return get_abrelshud_34Cell(level: level, index: index)
                } else if index.row == 3 {
                    return get_kouku_satonCell(index: index)
                } else if index.row == 4 {
                    return get_biackissCell(level: level, index: index)
                } else if index.row == 5 {
                    return get_valtanCell(level: level, index: index)
                }
            } else if level >= 1490 {
                if index.row == 1 {
                    return get_abrelshud_12Cell(level: level, index: index)
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
        
        if level >= 1600 {
            illiakanCell.raidNameLabel.attributedText = illiakanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            illiakanCell.raidNameLabel.attributedText = illiakanCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return illiakanCell
    }
    func get_abrelshud_12Cell(level: Float, index: IndexPath) -> Abrelshud_12TableViewCell {
        let abrelshud_12Cell = tableView.dequeueReusableCell(withIdentifier: "Abrelshud_12Cell", for: index) as! Abrelshud_12TableViewCell
        abrelshud_12Cell.level = level
        
        if level >= 1540 {
            abrelshud_12Cell.raidNameLabel.attributedText = abrelshud_12Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            abrelshud_12Cell.raidNameLabel.attributedText = abrelshud_12Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return abrelshud_12Cell
    }
    func get_abrelshud_34Cell(level: Float, index: IndexPath) -> Abrelshud_34TableViewCell {
        let abrelshud_34Cell = tableView.dequeueReusableCell(withIdentifier: "Abrelshud_34Cell", for: index) as! Abrelshud_34TableViewCell
        abrelshud_34Cell.level = level
        
        if level >= 1550 {
            abrelshud_34Cell.raidNameLabel.attributedText = abrelshud_34Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            abrelshud_34Cell.raidNameLabel.attributedText = abrelshud_34Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return abrelshud_34Cell
    }
    func get_abrelshud_56Cell(level: Float, index: IndexPath) -> Abrelshud_56TableViewCell {
        let abrelshud_56Cell = tableView.dequeueReusableCell(withIdentifier: "Abrelshud_56Cell", for: index) as! Abrelshud_56TableViewCell
        abrelshud_56Cell.level = level
        if level >= 1560 {
            abrelshud_56Cell.raidNameLabel.attributedText = abrelshud_56Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            abrelshud_56Cell.raidNameLabel.attributedText = abrelshud_56Cell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return abrelshud_56Cell
    }
    func get_kouku_satonCell(index: IndexPath) -> Kouku_SatonTableViewCell {
        let kouku_satonCell = tableView.dequeueReusableCell(withIdentifier: "Kouku_SatonCell", for: index) as! Kouku_SatonTableViewCell
        return kouku_satonCell
    }
    func get_biackissCell(level: Float, index: IndexPath) -> BiackissTableViewCell {
        let biackissCell = tableView.dequeueReusableCell(withIdentifier: "BiackissCell", for: index) as! BiackissTableViewCell
        biackissCell.level = level
        
        if level >= 1460 {
            biackissCell.raidNameLabel.attributedText = biackissCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
        } else {
            biackissCell.raidNameLabel.attributedText = biackissCell.raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
        }
        return biackissCell
    }
    func get_valtanCell(level: Float, index: IndexPath) -> ValtanTableViewCell {
        let valtanCell = tableView.dequeueReusableCell(withIdentifier: "ValtanCell", for: index) as! ValtanTableViewCell
        valtanCell.level = level

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
}
