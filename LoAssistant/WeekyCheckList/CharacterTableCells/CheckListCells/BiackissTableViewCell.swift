//
//  BiackissTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class BiackissTableViewCell: UITableViewCell {
    
    var level: Float = 0.0
    var charIndex: Int = Int()
    
    var delegate: GateButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var gate1Button: UIButton!
    @IBOutlet weak var gate2Button: UIButton!
    @IBOutlet weak var gate3Button: UIButton!
    
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//
//        print(self.checkList)
//        self.checkList![self.charIndex].biakiss = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].biakiss)")
//
//        print(self.checkList)
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(self.checkList) {
//            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
//        }
//        if sender.selectedSegmentIndex == 3 {
//            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
//        } else {
//            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
//            if level >= 1460 {
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
            delegate?.gateButtonTapped(gateNum: 1)
        }
    }
    @IBAction func gate2ButtonTapped(_ sender: Any) {
        gate1Button.isSelected = true
        gate3Button.isSelected = false
        gate2Button.isSelected = !gate2Button.isSelected
        
        if gate2Button.isSelected == true {
            delegate?.gateButtonTapped(gateNum: 2)
        }
    }
    @IBAction func gate3ButtonTapped(_ sender: Any) {
        gate1Button.isSelected = true
        gate2Button.isSelected = true
        gate3Button.isSelected = !gate3Button.isSelected
        
        if gate2Button.isSelected == true {
            delegate?.gateButtonTapped(gateNum: 3)
        }
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        DispatchQueue.global().sync {
            var checkList: [CheckList] = [CheckList]()
            
            if let savedData = UserDefaults.standard.object(forKey: "CharacterList") as? Data {
                let decoder = JSONDecoder()
                if let savedObject = try? decoder.decode([CheckList].self, from: savedData) {
                    checkList = savedObject
                }
            }
            
            checkList[self.charIndex].biakiss = segment.selectedSegmentIndex
            print("\(self.charIndex) : \(checkList[self.charIndex].biakiss)")
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(checkList) {
                UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
            }
            if segment.selectedSegmentIndex == 2 {
                raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
            } else {
                raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
                if level >= 1460 {
                    raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
                } else {
                    raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
                }
            }
        }
    }
}
