//
//  OrehaTableViewCell.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/08/24.
//

import UIKit

class OrehaTableViewCell: UITableViewCell {

    @IBOutlet weak var orehaImage: UIImageView!
    @IBOutlet weak var orehaNameLabel: UILabel!
    @IBOutlet weak var orehaPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
