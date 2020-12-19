//
//  PersistenceHelper.swift
//  ColorSwatches
//
//  Created by Christian Hurtado on 12/19/20.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    private var swatches = [ColorSwatch]()
    
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    private func save() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        do {
            let data = try PropertyListEncoder().encode(swatches)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    public func reorderEvents(swatches: [ColorSwatch]) {
        self.swatches = swatches
        try? save()
    }
    
    public func create(item: ColorSwatch, indexPath: Int) throws {
        
        do {
            swatches = try loadEvents()
        } catch {
            print("error while creating")
        }
        swatches.append(item)
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    public func loadEvents() throws -> [ColorSwatch] {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    swatches = try PropertyListDecoder().decode([ColorSwatch].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        }
        return swatches
    }
    
    public func delete(swatch index: Int) throws {
        let _ = try? loadEvents()
        swatches.remove(at: index)
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
