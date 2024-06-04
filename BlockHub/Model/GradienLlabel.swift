//
//  GradienLlabel.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import UIKit

class GradientLabel: UILabel {
    
    private var gradientColors: [UIColor] = [UIColor.white, UIColor.systemBlue, UIColor.systemPurple]
    
    func setGradientColors(_ colors: [UIColor]) {
        self.gradientColors = colors
        setNeedsDisplay()
    }
    
    override func drawText(in rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }
        
        let textSize = self.sizeThatFits(rect.size)
        let textRect = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = textRect
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        
        UIGraphicsBeginImageContextWithOptions(textRect.size, false, 0)
        guard let gradientContext = UIGraphicsGetCurrentContext() else {
            super.drawText(in: rect)
            return
        }
        
        gradientLayer.render(in: gradientContext)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        context.saveGState()
        context.clip(to: rect, mask: gradientImage!.cgImage!)
        super.drawText(in: rect)
        context.restoreGState()
    }
}
