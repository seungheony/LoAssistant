//
//  CheckListTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/18.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {

    var 관문수: Int = 0
    
    @IBOutlet weak var raidNameLabel: UILabel!
    @IBOutlet weak var raidGateWayControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for i in 0...관문수 {
            raidGateWayControl.setTitle("\(i+1)", forSegmentAt: i)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
