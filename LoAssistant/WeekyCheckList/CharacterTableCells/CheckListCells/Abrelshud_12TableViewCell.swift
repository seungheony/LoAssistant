//
//  AbrelshudTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class Abrelshud_12TableViewCell: UITableViewCell {

    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var geteSegment: UISegmentedControl!
    
    @IBAction func checkGate(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 2 {
            raidNameLabel.attributedText = raidNameLabel.text?.strikeThrough()
        } else {
            raidNameLabel.attributedText = raidNameLabel.text?.removeStrikeThrough()
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
