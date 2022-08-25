//
//  AbrelshudTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/25.
//

import UIKit

class Abrelshud_12TableViewCell: UITableViewCell {
    
    var difficulty :Difficulty = Difficulty.normal

    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var geteSegment: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
