//
//  ColorCVC.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

protocol ColorCellDel: AnyObject {
    func alertAction(_ swatchCell: ColorCVC)
}

class ColorCVC: UICollectionViewCell {
    
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    weak var delegate: ColorCellDel?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        addGestureRecognizer(longPressGesture)
    }
    
    func configureCell(_ color: ColorSwatch?) {
        self.layer.cornerRadius = 70
        colorName.text = color?.colorName ?? ""
        colorView.backgroundColor = UIColor(red: CGFloat(color!.red), green: CGFloat(color!.green), blue: CGFloat(color!.blue), alpha: CGFloat(color?.alpha ?? 1.0))
    }
    
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            delegate?.alertAction(self)
            gesture.state = .cancelled
            print("long press activated")
        }
    }
    
}
