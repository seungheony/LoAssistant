//
//  ResultTableViewCell.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/06/03.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profitPerCycle: UILabel!
    @IBOutlet weak var extraProfit: UILabel!
    @IBOutlet weak var profitPerMinute: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
