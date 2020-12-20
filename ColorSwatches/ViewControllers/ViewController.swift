//
//  ViewController.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/14/20.
//

import UIKit
import DataPersistence

class ViewController: UIViewController {
    
    @IBOutlet weak var colorCollection: UICollectionView!
    
    let colorPicker = UIColorPickerViewController()
    private let dataPersistence = PersistenceHelper(filename: "swatches.plist")
//    let colorSwatches = [ColorSwatch]()
    
    private var colorSwatches = [ColorSwatch]() {
        didSet {
            self.colorCollection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollection.dataSource = self
        loadColors()
//        colorCollection.delegate = self
    }
    
    private func loadColors() {
        do{
            colorSwatches = try dataPersistence.loadEvents()
            print(colorSwatches.count)
        } catch {
            print("loading events error: \(error)")
        }
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
