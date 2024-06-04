//
//  DelegateProtocol.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import Foundation

protocol CoursesTableViewCellDelegate: AnyObject {
    func didTapRegisterButton(cell: CoursesTableViewCell)
}
