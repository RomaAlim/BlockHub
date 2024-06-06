//
//  EntutyMyCourse.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import Foundation

protocol TableViewCellDelegate: AnyObject {
    func didTapCourseInformationButton(cell: TableViewCell)
    func didTapNextButton(cell: TableViewCell)
}
