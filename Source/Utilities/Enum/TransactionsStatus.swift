//
//  TransactionsStatus.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import Foundation
import UIKit

public enum TransactionsStatus: Int, Codable {
    case pending = 0
    case success
    case fail
    
    var title: String {
        switch self {
        case .success: return "transactions_status_success".localized
        case .pending: return "transactions_status_pending".localized
        case .fail: return "transactions_status_fail".localized
        }
    }
    
    var color: UIColor {
        switch self {
        case .success: return .wDarkGreen3
        case .pending: return .wYallowF9A
        case .fail: return .wRedE01
        }
    }
    
    var detailsIcon: String {
        switch self {
        case .success: return "success_record_icon"
        case .fail: return "failed_record_icon"
        case .pending: return "pending_record_icon"
        }
    }
    
}
