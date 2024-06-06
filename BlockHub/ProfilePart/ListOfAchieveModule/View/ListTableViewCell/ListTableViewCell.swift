//
//  ListTableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var achiveImageView: UIImageView!
    
    @IBOutlet weak var achieveDescriptionLabel: UILabel!
    @IBOutlet weak var achieveNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
