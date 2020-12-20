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
//        self.backgroundColor = color.color
    }
    
}
