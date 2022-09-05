//
//  CheckListSettingTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/09/02.
//

import UIKit

class CheckListSettingTableViewController: UITableViewController {
    
    var checkList: [CheckList] = []
    
    @IBOutlet weak var argosSwitch: UISwitch!
    @IBOutlet weak var kayangelSwitch: UISwitch!
    
    @IBOutlet weak var valtanSwitch: UISwitch!
    @IBOutlet weak var biakissSwitch: UISwitch!
    @IBOutlet weak var kouku_satonSwitch: UISwitch!
    @IBOutlet weak var abrelshudSwitch: UISwitch!
    @IBOutlet weak var illiakanSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.argosSwitch.isOn = !UserDefaults.standard.bool(forKey: "argosSwitch")
        self.kayangelSwitch.isOn = !UserDefaults.standard.bool(forKey: "kayangelSwitch")
        
        self.valtanSwitch.isOn = !UserDefaults.standard.bool(forKey: "valtanSwitch")
        self.biakissSwitch.isOn = !UserDefaults.standard.bool(forKey: "biakissSwitch")
        self.kouku_satonSwitch.isOn = !UserDefaults.standard.bool(forKey: "kouku_satonSwitch")
        self.abrelshudSwitch.isOn = !UserDefaults.standard.bool(forKey: "abrelshudSwitch")
        self.illiakanSwitch.isOn = !UserDefaults.standard.bool(forKey: "illiakanSwitch")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        } else if section == 1 {
            return 5
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    @IBAction func toggleArgos(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "argosSwitch")
    }
    @IBAction func toggleKayangel(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "kayangelSwitch")
    }
    
    @IBAction func toggleValtan(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "valtanSwitch")
    }
    @IBAction func toggleBiakiss(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "biakissSwitch")
    }
    @IBAction func toggleKouku_saton(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "kouku_satonSwitch")
    }
    @IBAction func toggleAbrelshud(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "abrelshudSwitch")
    }
    @IBAction func toggleIlliakan(_ sender: UISwitch) {
        UserDefaults.standard.set(!sender.isOn, forKey: "illiakanSwitch")
    }
}
