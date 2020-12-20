//
//  ColorCVC.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

class ColorCVC: UICollectionViewCell {
    
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    func configureCell(_ color: ColorSwatch?) {
        self.layer.cornerRadius = 70
        colorName.text = color?.colorName ?? ""
        colorView.backgroundColor = UIColor(red: CGFloat(color!.red), green: CGFloat(color!.green), blue: CGFloat(color!.blue), alpha: CGFloat(color?.alpha ?? 1.0))
    }
    
}
