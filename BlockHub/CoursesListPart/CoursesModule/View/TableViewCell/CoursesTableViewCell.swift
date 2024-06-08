//
//  CoursesTableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

import UIKit

protocol CoursesTableDelegate: AnyObject {
    func didTapRegisterButton(cell: CoursesTableViewCell)
}

class CoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var ViewEdite: UIView!
    @IBOutlet weak var imageViewListCourses: UIImageView!
    @IBOutlet weak var costListCourses: UILabel!
    @IBOutlet weak var nameListCourses: UILabel!
    @IBOutlet weak var descriptionListCourses1: UILabel!
    @IBOutlet weak var descriptionListCourses2: UILabel!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var CourseNameLabel: UILabel!
    
    weak var delegate: CoursesTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
            
            costListCourses.textColor = .link
            registrationButton.setTitleColor(.link, for: .normal)
            registrationButton.setTitle("Details".localized, for: .normal)
        
        // Округление углов для descriptionListCourses1
         descriptionListCourses1.layer.cornerRadius = 15
         descriptionListCourses1.layer.masksToBounds = true

         // Округление углов для descriptionListCourses2
         descriptionListCourses2.layer.cornerRadius = 15
         descriptionListCourses2.layer.masksToBounds = true
        }
        
    }
