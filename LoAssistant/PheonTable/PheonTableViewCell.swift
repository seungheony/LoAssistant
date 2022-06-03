//
//  PheonTableViewCell.swift
//  LoAssistant
//
//  Created by shkim-mac on 2022/06/03.
//

import UIKit

class PheonTableViewCell: UITableViewCell {

    @IBOutlet weak var imageX: UIImageView!
    @IBOutlet weak var x: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
