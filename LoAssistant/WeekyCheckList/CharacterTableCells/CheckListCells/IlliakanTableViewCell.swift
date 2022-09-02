//
//  IlliakanTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class IlliakanTableViewCell: UITableViewCell {

    var level: Float = 0.0
    var charIndex: Int = Int()
    var delegate: CheckButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    
    @IBOutlet weak var gate1Label: UILabel!
    @IBOutlet weak var gate2Label: UILabel!
    @IBOutlet weak var lastGateLabel: UILabel!
    
    @IBOutlet weak var gate1Button: UIButton!
    @IBOutlet weak var gate2Button: UIButton!
    @IBOutlet weak var gate3Button: UIButton!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        
//        self.checkList![self.charIndex].illiakan = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].illiakan)")
//        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(self.checkList) {
//            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
//        }
//        if sender.selectedSegmentIndex == 3 {
//            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
//        } else {
//            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
//            if level >= 1600 {
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
    @IBAction func gate1ButtonTapped(_ sender: Any) {
        gate2Button.isSelected = false
        gate3Button.isSelected = false
        gate1Button.isSelected = !gate1Button.isSelected
        
        if gate1Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    @IBAction func gate2ButtonTapped(_ sender: Any) {
        gate1Button.isSelected = true
        gate3Button.isSelected = false
        gate2Button.isSelected = !gate2Button.isSelected
        
        if gate2Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else if gate1Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    @IBAction func gate3ButtonTapped(_ sender: Any) {
        gate1Button.isSelected = true
        gate2Button.isSelected = true
        gate3Button.isSelected = !gate3Button.isSelected
        
        if gate3Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else if gate2Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
}
