//
//  NewsTableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsTitleTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsTitleTextView.isEditable = false
        newsTitleTextView.isSelectable = false
        newsTitleTextView.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
