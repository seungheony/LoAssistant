//
//  AbrelshudTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class Abrelshud_34TableViewCell: UITableViewCell {
    
    var level: Float = 0.0
    var charIndex: Int = Int()
    var delegate: GateButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    
    @IBOutlet weak var gate3Button: UIButton!
    @IBOutlet weak var gate4Button: UIButton!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        
//        self.checkList![self.charIndex].abrelshud_34 = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].abrelshud_34)")
//        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(self.checkList) {
//            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
//        }
//        if sender.selectedSegmentIndex == 2 {
//            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
//        } else {
//            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
//            if level >= 1550 {
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
    
    @IBAction func gate3ButtonTapped(_ sender: Any) {
        delegate?.gateButtonTapped()
    }
    @IBAction func gate4ButtonTapped(_ sender: Any) {
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
            
            checkList[self.charIndex].abrelshud_34 = segment.selectedSegmentIndex
            print("\(self.charIndex) : \(checkList[self.charIndex].abrelshud_34)")
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(checkList) {
                UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
            }
            if segment.selectedSegmentIndex == 2 {
                raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
            } else {
                raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
                if level >= 1550 {
                    raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "하드")
                } else {
                    raidNameLabel.attributedText = raidNameLabel.text?.setRaidNameAtAttributesStr(add: "노말")
                }
            }
        }
    }
}
