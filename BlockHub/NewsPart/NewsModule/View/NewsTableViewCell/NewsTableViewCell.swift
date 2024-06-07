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
            newsTitleTextView.isEditable = false
            newsTitleTextView.isSelectable = true
            newsTitleTextView.isUserInteractionEnabled = false
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    }
