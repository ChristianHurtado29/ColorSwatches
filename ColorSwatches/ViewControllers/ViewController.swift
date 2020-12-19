//
//  ViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorCollection: UICollectionView!
    
    let colorPicker = UIColorPickerViewController()
    
    
    private var colorSwatches = [ColorSwatch]() {
        didSet {
            self.colorCollection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollection.dataSource = self
//        colorCollection.delegate = self
    }
    
    @IBAction func colorPickerButton(_ sender: UIBarButtonItem) {
        
        present(colorPicker, animated: true)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorSwatches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "colorCVC", for: indexPath) as? ColorCVC else {
            fatalError("could not dequeu color cell")
        }
        let color = colorSwatches[indexPath.row]
        cell.configureCell(color)
        return cell
    }
    
    
}
