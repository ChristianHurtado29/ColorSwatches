//
//  ColorPickerViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import UIKit

protocol ColorDelegate: AnyObject{
    func colorTake(colorSwatch: ColorSwatch)
}

class ColorPickerViewController: UIViewController {
    
    let colorPickerView = UIColorPickerViewController()
    let colorWell = UIColorWell()
    
    weak var delegate: ColorDelegate?
    
    @IBOutlet weak var colorNameText: UITextField!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    public var colorSwatches = [ColorSwatch]()
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    private let dataPersistence = PersistenceHelper(filename: "swatches.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        colorWell.selectedColor = colorPickerView.selectedColor
        colorPickerView.delegate = self
        colorNameText.delegate = self
    }
    
    @IBAction func createSwatch(_ sender: UIButton) {
        let newColorSwatch = ColorSwatch(colorName: colorLabel.text!, red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
        delegate?.colorTake(colorSwatch: newColorSwatch)
        colorSwatches.insert(newColorSwatch, at: 0)
        
        do {
            try dataPersistence.create(item: newColorSwatch, indexPath: 0)
            print("created swatch")
            dismiss(animated: true)
        } catch {
            print("saving error \(error)")
        }
//        let showAlert = UIAlertController(title: "Color: \(newColorSwatch.colorName) saved", message: "Saved swatch!", preferredStyle: .alert)
//        showAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//        present(showAlert, animated: true)
        
    }
    
    @IBAction func colorPicker(_ sender: UIButton) {
        present(colorPickerView, animated: true)
    }
    
}

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = colorPickerView.selectedColor
        red = selectedColor.cgColor.components![0]
        green = selectedColor.cgColor.components![1]
        blue = selectedColor.cgColor.components![2]
        alpha = selectedColor.cgColor.alpha
        
        colorView.backgroundColor = selectedColor
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
