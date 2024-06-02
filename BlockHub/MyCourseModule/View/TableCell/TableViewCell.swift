//
//  TableViewCell.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var NameOfEducation: UILabel!
    @IBOutlet weak var NumberOfLessons: UILabel!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CourseInformation: UIButton!
    @IBOutlet weak var ProgresView: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func NextButtonAction(_ sender: Any) {
    }
    
    @IBAction func CourseInformationButton(_ sender: Any) {
    }
    private func setupUI() {
            // Установка зеленого цвета для ProgressView
            ProgresView.progressTintColor = .green
            
            // Округление углов кнопок
            NextButton.layer.cornerRadius = 5
            CourseInformation.layer.cornerRadius = 5
            
            // Настройка границ для корректного отображения
            NextButton.clipsToBounds = true
            CourseInformation.clipsToBounds = true
        }
}
