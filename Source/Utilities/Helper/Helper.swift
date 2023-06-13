//
//  Helper.swift
//  WalletSDK
//
//  Created by ashahrouj on 04/01/2023.
//

import Foundation
import UIKit

public class Helper {
 
    public static let shared = Helper()
    private init() { }
    
    public func convertObjectToJson<T: Encodable>(with object: T) -> String? {
        do {
            let encodedData = try JSONEncoder().encode(object.self)
            let jsonString = String(data: encodedData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }

    public func convertJsonToObject<T: Decodable>(with value: T.Type, with jsonString: String) -> T?  {
        do {
            guard let dataFromJsonString = jsonString.data(using: .utf8) else { return nil}
            let data = try JSONDecoder().decode(value, from: dataFromJsonString)
            return data
        } catch(let error) {
            print("convertJsonToObject...\(error)")
            return nil
        }
    }
}

extension Helper {
    
    public func generatingQRCodes(for text: String) -> UIImage? {
        // Get define string to encode
        let myString = text
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
