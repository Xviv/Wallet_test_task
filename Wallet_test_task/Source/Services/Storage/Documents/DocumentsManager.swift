//
//  DocumentsManager.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class DocumentsManager {
    
    func save(_ image: UIImage, name: String) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = image.jpegData(compressionQuality:  1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileURL.absoluteString
            } catch {
                print("error saving file:", error)
            }
        }
        return nil
    }
    
    func delete(name:String) -> String? {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return nil
        }
        let filePath = "\(dirPath)/\(name)"
        do {
            try fileManager.removeItem(atPath: filePath)
            print("Deleted")
            return "file://\(filePath)"
        } catch let error as NSError {
            print(error.debugDescription)
        }
        return nil
    }
}
