//
//  TransactionRowModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import Foundation
import UIKit

struct TransactionRowModel {
    let iconName: String
    let iconColor: UIColor
    let iconTitle: String
    var title: String
    var shouldHideAddress: Bool = false
}
