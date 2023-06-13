//
//  UIImageView+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/01/2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    func generatingQRCodes(for text: String) -> UIImage? {
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
    
    func ahmadTest() {
        print("nothing changed....")
    }
}

