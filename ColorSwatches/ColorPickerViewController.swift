//
//  ColorPickerViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    let colorPickerView = UIColorPickerViewController()
    
    @IBOutlet weak var colorNameText: UITextField!
    @IBOutlet weak var colorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createSwatch(_ sender: UIButton) {
    }
    
    @IBAction func colorPicker(_ sender: UIButton) {
        present(colorPickerView, animated: true)
    }
    
}
