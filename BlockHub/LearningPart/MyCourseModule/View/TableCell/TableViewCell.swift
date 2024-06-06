//
//  TableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

import UIKit

protocol TableViewCellDelegateMyCourseModule: AnyObject {
    func didTapCourseInformationButton(cell: TableViewCell)
    func didTapNextButton(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var NameOfEducation: UILabel!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CourseInformation: UIButton!
    @IBOutlet weak var passedLabelStatus: UILabel!
    @IBOutlet weak var checkMarkStatus: UIImageView!
    
    weak var delegate: TableViewCellDelegateMyCourseModule?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func NextButtonAction(_ sender: Any) {
        delegate?.didTapNextButton(cell: self)
    }
    
    @IBAction func CourseInformationButton(_ sender: Any) {
       delegate?.didTapCourseInformationButton(cell: self)
    }
    private func setupUI() {

            NextButton.layer.cornerRadius = 5
            CourseInformation.layer.cornerRadius = 5

            NextButton.clipsToBounds = true
            CourseInformation.clipsToBounds = true
        
        if let gradientColor = UIView.createGradientBackground() {
            NextButton.backgroundColor = gradientColor
        }
    

        }
    
    func configure(with course: MyCourse) {
            NameOfEducation.text = course.name
            passedLabelStatus.text = course.isPassed ? "Passed" : "In Progress"
            
            if course.isPassed {
                checkMarkStatus.tintColor = .green
            } else {
                checkMarkStatus.tintColor = .gray
            }
        }
}
