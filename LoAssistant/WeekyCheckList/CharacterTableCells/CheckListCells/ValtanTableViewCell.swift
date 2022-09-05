//
//  ValtanTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class ValtanTableViewCell: UITableViewCell {
    
    var level: Float = 0.0
    var charIndex: Int = Int()
    
    var delegate: CheckButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    
    @IBOutlet weak var gate1Label: UILabel!
    @IBOutlet weak var lastGateLabel: UILabel!
    
    @IBOutlet weak var gate1Button: UIButton!
    @IBOutlet weak var gate2Button: UIButton!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        
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
        gate1Button.isSelected = !gate1Button.isSelected

        if gate1Button.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }
    }
    
    @IBAction func gate2ButtonTapped(_ sender: Any) {
        gate1Button.isSelected = true
        gate2Button.isSelected = !gate2Button.isSelected
        
        if UserDefaults.standard.bool(forKey: "valtanSwitch") {
            if gate2Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else {
                gate1Button.isSelected = false
                delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        } else {
            if gate2Button.isSelected == true {
                delegate?.checkButtonTapped(gateNum: 2, raidName: raidNameLabel.text!, charIndex: charIndex)
            } else {
                delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
            }
        }
        
    }
}
