//
//  OrehaSettingViewControllerTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/05/31.
//

import UIKit

class OrehaSettingViewController: UITableViewController {
    
    @IBOutlet weak var 페일린: UISwitch!
    @IBOutlet weak var 니아: UISwitch!
    @IBOutlet weak var 실리안: UISwitch!
    
    @IBOutlet weak var ASML: UISwitch!
    @IBOutlet weak var 여신의가호: UISwitch!
    @IBOutlet weak var 가림막: UISwitch!
    
    @IBOutlet weak var 자급자족: UISwitch!
    @IBOutlet weak var 발전기: UISwitch!
    @IBOutlet weak var 커피머신: UISwitch!
    @IBOutlet weak var 니나브: UISwitch!
    
    @IBOutlet weak var 노동요: UISwitch!
    @IBOutlet weak var 손놀림: UISwitch!
    @IBOutlet weak var 자동기계: UISwitch!
    @IBOutlet weak var 제작설계도: UISwitch!
    
    
    @IBOutlet weak var workshopLevel: UILabel!
    @IBOutlet weak var 제작공방: UISlider!
    @IBAction func workshopSlider(_ sender: UISlider) {
        let value: Int = Int(sender.value)
        UserDefaults.standard.set(value, forKey: "제작공방")
        workshopLevel.text = String(value) + " 레벨"
    }
    
    @IBOutlet weak var minInterOreha: UILabel!
    @IBOutlet weak var minInterSlider: UISlider!
    @IBAction func minInterSlider(_ sender: UISlider) {
        let value: Int = Int(sender.value)
        UserDefaults.standard.set(value, forKey: "중급기준")
        minInterOreha.text = String(value * 1000) + "개"
    }
    
    @IBOutlet weak var minAdvOreha: UILabel!
    @IBOutlet weak var minAdvSlider: UISlider!
    @IBAction func minAdvSlider(_ sender: UISlider) {
        let value: Int = Int(sender.value)
        UserDefaults.standard.set(value, forKey: "상급기준")
        minAdvOreha.text = String(value * 1000) + "개"
    }
    
    @IBOutlet weak var minUpperOreha: UILabel!
    @IBOutlet weak var minUpperSlider: UISlider!
    @IBAction func minUpperSlider(_ sender: UISlider) {
        let value: Int = Int(sender.value)
        UserDefaults.standard.set(value, forKey: "최상급기준")
        minUpperOreha.text = String(value * 1000) + "개"
    }
    
    @IBAction func 페일린(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "페일린")
    }
    @IBAction func 니아(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "니아")
    }
    @IBAction func 실리안(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "실리안")
    }
    @IBAction func ASML(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "ASML")
    }
    @IBAction func 여신의가호(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "여신의가호")
    }
    @IBAction func 가림막(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "가림막")
    }
    @IBAction func 자급자족(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "자급자족")
    }
    @IBAction func 발전기(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "발전기")
    }
    @IBAction func 커피머신(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "커피머신")
    }
    
    @IBAction func 노동요(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "노동요")
    }
    @IBAction func 손놀림(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "손놀림")
    }
    @IBAction func 자동기계(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "자동기계")
    }
    @IBAction func 제작설계도(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "제작설계도")
    }
    
    @IBAction func 니나브(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "니나브")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.페일린.isOn = UserDefaults.standard.bool(forKey: "페일린")
        self.니아.isOn = UserDefaults.standard.bool(forKey: "니아")
        self.실리안.isOn = UserDefaults.standard.bool(forKey: "실리안")
        self.ASML.isOn = UserDefaults.standard.bool(forKey: "ASML")
        self.여신의가호.isOn = UserDefaults.standard.bool(forKey: "여신의가호")
        self.가림막.isOn = UserDefaults.standard.bool(forKey: "가림막")
        self.자급자족.isOn = UserDefaults.standard.bool(forKey: "자급자족")
        self.발전기.isOn = UserDefaults.standard.bool(forKey: "발전기")
        self.커피머신.isOn = UserDefaults.standard.bool(forKey: "커피머신")
        
        self.노동요.isOn = UserDefaults.standard.bool(forKey: "노동요")
        self.손놀림.isOn = UserDefaults.standard.bool(forKey: "손놀림")
        self.자동기계.isOn = UserDefaults.standard.bool(forKey: "자동기계")
        self.제작설계도.isOn = UserDefaults.standard.bool(forKey: "제작설계도")
        
        self.니나브.isOn = UserDefaults.standard.bool(forKey: "니나브")
        self.제작공방.value = UserDefaults.standard.float(forKey: "제작공방")
        self.workshopLevel.text = String(Int(UserDefaults.standard.float(forKey: "제작공방"))) + " 레벨"
        
        self.minInterSlider.value = UserDefaults.standard.float(forKey: "중급기준")
        self.minInterOreha.text = String(Int(UserDefaults.standard.float(forKey: "중급기준")) * 1000) + "개"
        
        self.minAdvSlider.value = UserDefaults.standard.float(forKey: "상급기준")
        self.minAdvOreha.text = String(Int(UserDefaults.standard.float(forKey: "상급기준")) * 1000) + "개"
        
        self.minUpperSlider.value = UserDefaults.standard.float(forKey: "최상급기준")
        self.minUpperOreha.text = String(Int(UserDefaults.standard.float(forKey: "최상급기준")) * 1000) + "개"
    }

}
