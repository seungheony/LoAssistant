//
//  ResultTableViewCell.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/06/03.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var interImage: UIImageView!
    @IBOutlet weak var interPrice: UILabel!
    @IBOutlet weak var advImage: UIImageView!
    @IBOutlet weak var advPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
