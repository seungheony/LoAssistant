//
//  ExpeditionTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/23.
//

import UIKit

class ExpeditionTableViewCell: UITableViewCell {

    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charClassImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
