//
//  ViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    let colorPicker = UIColorPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func colorPickerButton(_ sender: UIBarButtonItem) {
        
        present(colorPicker, animated: true)
    }
    


}

