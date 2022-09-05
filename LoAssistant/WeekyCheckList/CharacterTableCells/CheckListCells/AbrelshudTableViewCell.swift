//
//  AbrelshudTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class AbrelshudTableViewCell: UITableViewCell {
    
    var level: Float = 0.0
    var charIndex: Int = Int()
    var delegate: CheckButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    
    @IBOutlet weak var gate12Label: UILabel!
    @IBOutlet weak var gate34Label: UILabel!
    @IBOutlet weak var lastGateLabel: UILabel!
    
    @IBOutlet weak var gate12Button: UIButton!
    @IBOutlet weak var gate34Button: UIButton!
    @IBOutlet weak var gate56Button: UIButton!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        
//        self.checkList![self.charIndex].abrelshud_12 = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].abrelshud_12)")
//        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(self.checkList) {
//            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
//        }
//        if sender.selectedSegmentIndex == 2 {
//            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
//        } else {
//            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
//            if level >= 1540 {
//                raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
//            } else {
//                raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
//            }
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func gate12ButtonTapped(_ sender: Any) {
        gate34Button.isSelected = false
        gate56Button.isSelected = false
        gate12Button.isSelected = !gate12Button.isSelected
        
        if gate12Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    @IBAction func gate34ButtonTapped(_ sender: Any) {
        gate12Button.isSelected = true
        gate56Button.isSelected = false
        gate34Button.isSelected = !gate34Button.isSelected
        
        if gate34Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else if gate12Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    @IBAction func gate56ButtonTapped(_ sender: Any) {
        gate12Button.isSelected = true
        gate34Button.isSelected = true
        gate56Button.isSelected = !gate56Button.isSelected
        
        if UserDefaults.standard.bool(forKey: "abrelshudSwitch") {
            if gate56Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else if gate34Button.isSelected == true {
                gate12Button.isSelected = false
                gate34Button.isSelected = false
                delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        } else {
            if gate56Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else if gate34Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        }
    }
}
