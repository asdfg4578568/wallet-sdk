//
//  FileManager.swift
//  WalletSDK
//
//  Created by ashahrouj on 04/01/2023.
//

import Foundation

public class LocalFileManager {
    
    public enum LocalFilePath: String {
        case walletSdk = "sdk"
    }
    
    public static let shared = LocalFileManager()

    private let documents: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/"
    
    private init() { }
    
    public func createDirectory(path: String) {
        let fullPath = documents + path
        if !FileManager.default.fileExists(atPath: fullPath) {
            do {
                try FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: true)
            } catch (let err) {
                debugPrint("Something wrong when trying to create a file:\(err)")
            }
        } else {
            debugPrint("The file already exists: \(path)")
        }
    }
    
    public func getPath(for file: LocalFilePath) -> String {
        return documents + file.rawValue
    }
}
