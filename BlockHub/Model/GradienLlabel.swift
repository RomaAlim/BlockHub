//
//  GradienLlabel.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func createGradientBackground() -> UIColor? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 96/255, green: 171/255, blue: 243/255, alpha: 1).cgColor,
            UIColor(red: 74/255, green: 119/255, blue: 245/255, alpha: 1).cgColor,
            UIColor(red: 59/255, green: 91/255, blue: 246/255, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0893, 0.5034, 0.8255]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.frame = CGRect(origin: .zero, size: size)
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIColor(patternImage: image!)
        }
        return nil
    }
}
