//
//  DetailViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/20/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    var colorSwatch: ColorSwatch?
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var colorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = colorSwatch?.colorName ?? ""
        redLabel.text = "Red value: \(colorSwatch?.red.description ?? "")"
        greenLabel.text = "Green value: \(colorSwatch?.green.description ?? "")"
        blueLabel.text = "Blue value: \(colorSwatch?.blue.description ?? "")"
        colorView.backgroundColor = UIColor(red: CGFloat(colorSwatch?.red ?? 0.0), green: CGFloat(colorSwatch?.green ?? 0.0), blue: CGFloat(colorSwatch?.blue ?? 0.0), alpha: CGFloat(colorSwatch?.alpha ?? 1.0))
        print(colorSwatch?.colorName)
    }
    
    
    
}
