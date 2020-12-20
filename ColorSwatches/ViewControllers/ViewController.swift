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
    
    private var colorSwatches = [ColorSwatch]() {
        didSet {
            self.colorCollection.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadColors()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colorCollection.dataSource = self
        colorCollection.delegate = self
        loadColors()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        guard let detailVC = segue.destination as? DetailViewController, let indexPath = colorCollection.indexPathsForSelectedItems?.first else {
//            fatalError("could not dequeue swatch color")
//        }
//        detailVC.colorSwatch = colorSwatches[indexPath.row]
//    }
    
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
    
    func deletingSwatch(indexPath: IndexPath) {
        do {
            try dataPersistence.delete(swatch: indexPath.row)
            colorSwatches.remove(at: indexPath.row)
        } catch {
            print("could not delete swatch: \(error.localizedDescription)")
        }
        dismiss(animated: true)
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
        cell.delegate = self as ColorCellDel
        cell.configureCell(color)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.275
        return  CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

extension ViewController: ColorCellDel {
    func alertAction(_ swatchCell: ColorCVC) {
        guard let indexPath = colorCollection.indexPath(for: swatchCell) else {
            return
        }
        
        let showAlert = UIAlertController(title: "Actions", message: "Which would you like to do?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deletingSwatch(indexPath: indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        showAlert.addAction(deleteAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true)
        
    }
    
    
}
