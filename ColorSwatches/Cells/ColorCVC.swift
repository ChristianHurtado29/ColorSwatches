//
//  ColorCVC.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

class ColorCVC: UICollectionViewCell {
    
    @IBOutlet weak var colorName: UILabel!
    
    func configureCell(_ color: ColorSwatch?) {
        colorName.text = color?.colorName ?? ""
        self.backgroundColor = UIColor(red: CGFloat(color!.red), green: CGFloat(color!.green), blue: CGFloat(color!.blue), alpha: 1)
    }
    
}
