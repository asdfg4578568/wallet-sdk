//
//  BackupSecondNoticeViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 03/01/2023.
//

import Foundation

class BackupSecondNoticeViewModel {
    
    enum NextBackupFlow {
        case BackUpMnemonicPhrase
        case DisplayPrivateKey
        
        var shouldHideBackButton: Bool {
            switch self {
            case .BackUpMnemonicPhrase: return true
            case .DisplayPrivateKey: return false
            }
        }
        
        var text: String {
            switch self {
            case .DisplayPrivateKey:
                return "backup_privateKey_security_warning".localized
            case .BackUpMnemonicPhrase:
                return "backup_sead_phrase_security_warning".localized
            }
        }
    }
    
    let nextBackupFlow: NextBackupFlow
    init(with nextBackupFlow: NextBackupFlow = .BackUpMnemonicPhrase) {
        self.nextBackupFlow = nextBackupFlow
    }
}
