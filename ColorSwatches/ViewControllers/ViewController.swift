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
        colorCollection.delegate = self
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 5
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = (3 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        let itemHeight: CGFloat = maxSize.height * 0.20
        return  CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
    }
}
