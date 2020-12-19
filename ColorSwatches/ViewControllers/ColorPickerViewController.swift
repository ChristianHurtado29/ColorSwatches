//
//  ColorPickerViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    let colorPickerView = UIColorPickerViewController()
    let colorWell = UIColorWell()
    
    @IBOutlet weak var colorNameText: UITextField!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorWell.selectedColor = colorPickerView.selectedColor
        colorPickerView.delegate = self
        colorNameText.delegate = self
    }
    
    @IBAction func createSwatch(_ sender: UIButton) {
//        let newColorSwatch = ColorSwatch(colorName: colorLabel.text ?? "", color: colorView.backgroundColor!)
//        let showAlert = UIAlertController(title: "Color: \(newColorSwatch.colorName) saved", message: "saved swatch!", preferredStyle: .alert)
//        showAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//        present(showAlert, animated: true)
    }
    
    @IBAction func colorPicker(_ sender: UIButton) {
        present(colorPickerView, animated: true)
    }
    
}

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorView.backgroundColor = colorPickerView.selectedColor
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorView.backgroundColor = viewController.selectedColor
    }
}

extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        colorLabel.text = textField.text
        textField.resignFirstResponder()
        return true
    }
}
