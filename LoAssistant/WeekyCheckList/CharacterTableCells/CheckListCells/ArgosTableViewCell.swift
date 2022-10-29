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
    
    @IBOutlet weak var phase1Label: UILabel!
    @IBOutlet weak var phase2Label: UILabel!
    @IBOutlet weak var lastPhaseLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UserDefaults.standard.bool(forKey: "argosSwitch") {
            phase1Button.isHidden = true
            phase2Button.isHidden = true
        }
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
        
        if UserDefaults.standard.bool(forKey: "argosSwitch") {
            if phase3Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else if phase2Button.isSelected == true {
                phase2Button.isSelected = false
                phase1Button.isSelected = false
                delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        } else {
            if phase3Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else if phase2Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        }
    }
    
    
}
