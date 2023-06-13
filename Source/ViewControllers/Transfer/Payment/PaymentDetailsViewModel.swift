//
//  PaymentDetailsViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import Foundation
import UIKit

struct PaymentModel {
    var balance: Double
    var addressTo: String
    var addressFrom: String
    var estimatedFees: Double
    var priceFees: Double
    var equation: String
    var asset: CurrencyAssetsEnum
}

class PaymentInfoModel {
    
    let iconName: String
    let titleInfo: (text:String, font: UIFont)
    let subTitleInfo: (text:String, font: UIFont)
    var secondSubTitleInfo: (text:String, font: UIFont)? = nil
    
    init(iconName: String, titleInfo: (text: String, font: UIFont), subTitleInfo: (text: String, font: UIFont), secondSubTitleInfo: (text:String, font: UIFont)? = nil) {
        self.iconName = iconName
        self.titleInfo = titleInfo
        self.subTitleInfo = subTitleInfo
        self.secondSubTitleInfo = secondSubTitleInfo
    }
}

class PaymentDetailsViewModel {
    
    var arrayOfPaymentInfo: [PaymentInfoModel] = []
    
    let paymentModel: PaymentModel
    init(with paymentModel: PaymentModel) {
        self.paymentModel = paymentModel
        arrayOfPaymentInfo = [
            PaymentInfoModel(iconName: "payment_info_icon", titleInfo: (text: "transfer_payment_info_title".localized, font: .font(name: .semiBold, and: 14)), subTitleInfo: (text: "\(paymentModel.asset.name) Transfer", font: .font(name: .semiBold, and: 16))),
            PaymentInfoModel(iconName: "payment_info_to_icon", titleInfo: (text: "transfer_payment_to_title".localized, font: .font(name: .semiBold, and: 14)), subTitleInfo: (text: paymentModel.addressTo, font: .font(name: .regular, and: 12))),
            PaymentInfoModel(iconName: "payment_info_from_icon", titleInfo: (text: "transfer_payment_from_title".localized, font: .font(name: .semiBold, and: 14)), subTitleInfo: (text: paymentModel.addressFrom, font: .font(name: .regular, and: 12))),
            PaymentInfoModel(iconName: "payment_info_miner_fee_icon", titleInfo: (text: "transfer_payment_miner_fee_title".localized, font: .font(name: .semiBold, and: 14)), subTitleInfo: (text: "\(paymentModel.estimatedFees.descriptionFor12Digits)\(paymentModel.asset.nameOnlyForTransfer)", font: .font(name: .regular, and: 12)), secondSubTitleInfo: (text: "\(paymentModel.equation)", font: .font(name: .regular, and: 12)))
        ]
    }
}
