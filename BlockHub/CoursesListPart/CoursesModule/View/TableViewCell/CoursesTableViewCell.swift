//
//  CoursesTableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

import UIKit


class CoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewEdite: UIView!
    @IBOutlet weak var imageViewListCourses: UIImageView!
    @IBOutlet weak var costListCourses: UILabel!
    @IBOutlet weak var nameListCourses: UILabel!
    @IBOutlet weak var descriptionListCourses1: UILabel!
    @IBOutlet weak var descriptionListCourses2: UILabel!
    @IBOutlet weak var registrationButton: UIButton!
    
    weak var delegate: CoursesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI() 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        delegate?.didTapRegisterButton(cell: self)
    }
    
    private func setupUI() {
        // Округление углов для ViewEdite
        ViewEdite.layer.cornerRadius = 10
        ViewEdite.layer.masksToBounds = true
        
        // Установка границы для ViewEdite
        ViewEdite.layer.borderWidth = 1
        ViewEdite.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor

        // Округление углов кнопки
        registrationButton.layer.cornerRadius = 10
        registrationButton.clipsToBounds = true
        
        // Установка рамки для кнопки
        registrationButton.layer.borderWidth = 1
        registrationButton.layer.borderColor = UIColor.link.cgColor
        registrationButton.layer.backgroundColor = UIColor.clear.cgColor
    }
}
