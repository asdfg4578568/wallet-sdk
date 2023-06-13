//
//  TransactionsHistoryOptions.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import Foundation
import UIKit

public enum TransactionsHistoryOptions: Int, CaseIterable, Codable {
    case all
    case send
    case receive
    
    var title: String {
        switch self {
        case .all: return "currency_details_pager_all".localized
        case .send: return "currency_details_pager_send".localized
        case .receive: return "currency_details_pager_receive".localized
        }
    }
    
    var transactionsTitle: String {
        switch self {
        case .all: return ""
        case .send: return "history_list_out_title".localized
        case .receive: return "history_list_in_title".localized
        }
    }
    
    var transactionsTitleColor: UIColor {
        switch self {
        case .all: return .clear
        case .send: return .wRedE01
        case .receive: return .wDarkGreen3
        }
    }
    
    var transactionsIcon: String {
        switch self {
        case .all: return ""
        case .send: return "arrow_up_right_red_icon"
        case .receive: return "arrow_down_left_green_icon"
        }
    }
    
    
}
