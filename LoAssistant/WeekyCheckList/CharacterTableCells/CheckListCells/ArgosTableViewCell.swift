//
//  ArgosTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class ArgosTableViewCell: UITableViewCell {
    
    var charIndex: Int = Int()
    var delegate: CheckButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var phase1Button: UIButton!
    @IBOutlet weak var phase2Button: UIButton!
    @IBOutlet weak var phase3Button: UIButton!
    @IBOutlet weak var lastPhaseLabel: UILabel!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        
//        self.checkList![self.charIndex].argos = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].argos)")
//        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(self.checkList) {
//            UserDefaults.standard.setValue(encoded, forKey: "CharacterList")
//        }
//        if sender.selectedSegmentIndex == 3 {
//            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
//        } else {
//            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
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
    
    @IBAction func phase1ButtonTapped(_ sender: Any) {
        phase2Button.isSelected = false
        phase3Button.isSelected = false
        phase1Button.isSelected = !phase1Button.isSelected
        
        if phase1Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    @IBAction func phase2ButtonTapped(_ sender: Any) {
        phase1Button.isSelected = true
        phase3Button.isSelected = false
        phase2Button.isSelected = !phase2Button.isSelected
        
        if phase2Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else if phase1Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    @IBAction func phase3ButtonTapped(_ sender: Any) {
        phase1Button.isSelected = true
        phase2Button.isSelected = true
        phase3Button.isSelected = !phase3Button.isSelected
        
        if phase3Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else if phase2Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    
}
