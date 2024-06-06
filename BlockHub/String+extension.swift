//
//  String+extension.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation

extension String{
    
    var localized:String{
        NSLocalizedString(self, comment: "\(self) could not be found un Localizable.strings")
    }
}
