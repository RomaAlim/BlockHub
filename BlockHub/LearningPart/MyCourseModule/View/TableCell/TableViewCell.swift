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
           
        NextButton.backgroundColor = .link
           
           NextButton.setTitle("continue".localized, for: .normal)
           CourseInformation.setTitle("course_information".localized, for: .normal)
       }
       
       func configure(with course: Course) {
           NameOfEducation.text = course.name
           // Assuming there is a field indicating the passed status in your Course model, for example, `isPassed`
           // passedLabelStatus.text = course.isPassed ? "passed".localized : "in_progress".localized
           
           // Assuming there's a way to determine if the course is passed in your Course model
           // Here, it's assumed that the Course model has an `isPassed` boolean field
           // This might need to be adjusted based on the actual data structure
           
           // Placeholder logic for `isPassed`, adjust as necessary
//           let isPassed = course.modules.allSatisfy { module in
//               module.moduleTest?.submissions.first?.passed == true//Value of type 'ModuleTest' has no member 'submissions'
//           }
//                    checkMarkStatus.tintColor = isPassed ? .green : .gray
       }
   }
