//
//  Kouku-SatonTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class Kouku_SatonTableViewCell: UITableViewCell {
    
    var charIndex: Int = Int()
    
    var delegate: CheckButtonTappedDelegate?
    
    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var gate3Button: UIButton!
    
//    @IBAction func checkGate(_ sender: UISegmentedControl) {
//        print(self.checkList)
//        self.checkList![self.charIndex].kouku_saton = sender.selectedSegmentIndex
//        print("\(self.charIndex) : \(self.checkList![self.charIndex].kouku_saton)")
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
        gate3Button.isSelected = !gate3Button.isSelected
        
        if gate3Button.isSelected == true {
            print("selected")
            delegate?.checkButtonTapped(gateNum: 3, raidName: raidNameLabel.text!, charIndex: charIndex)
        } else {
            delegate?.checkButtonTapped(gateNum: 0, raidName: raidNameLabel.text!, charIndex: charIndex)
        }

    }
}
