//
//  ChaptersTableCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import UIKit

class ChaptersTableCell: UITableViewCell {

    
    @IBOutlet weak var ViewCornerUI: UIView!
    @IBOutlet weak var chapterTitleUI: UILabel!
    @IBOutlet weak var progressTextUI: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(){
        // Setup the border view
        ViewCornerUI.layer.cornerRadius = 20
        ViewCornerUI.layer.borderWidth = 1
        ViewCornerUI.layer.borderColor = UIColor.systemBlue.cgColor

        // Additional customization (optional)
        ViewCornerUI.layer.masksToBounds = true
    
            chapterTitleUI.textColor = .link
        

    }
}
