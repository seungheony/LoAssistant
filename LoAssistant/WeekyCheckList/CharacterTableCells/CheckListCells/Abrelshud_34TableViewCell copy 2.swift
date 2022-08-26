//
//  AbrelshudTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class Abrelshud_34TableViewCell: UITableViewCell {
    
    var level: Float = 0.0

    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var geteSegment: UISegmentedControl!
    
    @IBAction func checkGate(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 2 {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
