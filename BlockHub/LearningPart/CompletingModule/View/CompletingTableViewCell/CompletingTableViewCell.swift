//
//  CompletingTableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit

class CompletingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var nameTypeLabel: UILabel!
    @IBOutlet weak var typleLabel: UILabel!
    @IBOutlet weak var viewEditedCorner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: LessonItem) {
        imageType.image = item.image
        nameTypeLabel.text = item.name
        typleLabel.text = item.type
        
    }
    
    func updateUI(){
        viewEditedCorner.layer.cornerRadius = 20
        if let gradientColor = UIView.createGradientBackground() {
            nameTypeLabel.textColor = gradientColor
        }

    }

}
