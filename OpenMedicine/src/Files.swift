//
//  Files.swift
//  Files
//
//  Created by Nurlan Nihonda on 12/9/21.
//

import Foundation

// https://stackoverflow.com/questions/65533354/saving-changes-from-a-loaded-json-file-to-core-data-in-swiftui
class Files {
    static let shared = Files()
    
    func read<T: Decodable>(filename: String) -> T? {
        let data: Data

        let localPath = getDocumentsDirectory().appendingPathComponent(filename)

        if exists(filename) {
            do {
                data = try Data(contentsOf: localPath)
            } catch {
               fatalError("Couldn't load \(filename) from documents directory:\n\(error)")
            }
        } else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func write<T: Encodable>(filename: String, item: T) {
        let encoder = JSONEncoder()
        do {
            let url = getDocumentsDirectory().appendingPathComponent(filename)
            let encoded = try encoder.encode(item)
            let jsonString = String(data: encoded, encoding: .utf8)
            try jsonString?.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            // handle your error
        }
    }
    
    func exists(_ filename: String) -> Bool {
        let filemanager = FileManager.default
        let localPath = getDocumentsDirectory().appendingPathComponent(filename)
        
        return filemanager.fileExists(atPath: localPath.path)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
