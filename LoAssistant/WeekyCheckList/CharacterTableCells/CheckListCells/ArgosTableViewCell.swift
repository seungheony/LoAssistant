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
    @IBOutlet weak var checkButton: UIButton!
    
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
    
    @IBAction func gate1ButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        
        if checkButton.isSelected == true {
            delegate?.checkButtonTapped(gateNum: 1, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }

    }
}
