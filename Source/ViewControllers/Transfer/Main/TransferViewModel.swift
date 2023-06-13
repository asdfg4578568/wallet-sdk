//
//  TransferViewModel.swift
//  WalletSDK
//
//  Created by ashahrouj on 30/12/2022.
//

import Foundation

public class TransferViewModel {
    
    enum ValidationMeesage {
        case inputAddress
        case inputTransferAmount
        case balanceNotEnough
        case checkEstimatedFee
        case lessThanTransaction(String, String)
        case nothing
        
        var description: String {
            switch self {
            case .inputAddress: return "transfer_please_input_address".localized
            case .inputTransferAmount: return "transfer_please_input_transfer_amount".localized
            case .balanceNotEnough: return "transfer_balance_not_enough".localized
            case .checkEstimatedFee: return "transfer_please_check_estimated_fee".localized
            case .nothing: return ""
            case .lessThanTransaction(let assetName, let estimatedFees):
                return String(format: "transfer_less_than_transaction_fee".localized, assetName, estimatedFees)
            }
        }
    }
    
    private(set) var shouldHideMinersFees: Bool
    private(set) var currencyModel: CurrencyModel
    private var coinRatioForTransfer: CoinRatioModel?
    private var coinRatioForMiner: CoinRatioModel?

    // For amount
    var shouldDisplayPopup: Bool { return addressTo?.count ?? 0 <= 0 || balanceToSend.count == 0 }
    var addressTo: String?
    var totalBalance: String
    var balanceToSend:String = ""
    var normalCurrencyCode = "\(SDKManager.shared.currencySymbol.symbol)"
    var normalCurrencyBalance: String = ""
    var fixedTotalBalance: Double

    var publicAddress: String = ""

    // For miner's fees
    var gasFeesArry: [GasFeesPriorityModel] = []
    var gasFeesSelectedIndex: Int = 0
    
    var didFinishedGetEstimatedFees: (Bool) -> Void = { _ in }
    var estimatedNormalCurrencyFeesForDisplay: String = ""
    var estimatedNormalCurrencyFees: Double = 0 {
        didSet {
            estimatedNormalCurrencyFeesForDisplay = (estimatedNormalCurrencyFees * (coinRatioForMiner?.yuan ?? 0)).descriptionFor2Digits
            didFinishedGetEstimatedFees(true)
        }
    }
    
    var estimatedFeesForDisplay: String = ""
    var estimatedFees: Double = 0 {
        didSet {
            estimatedFeesForDisplay = "\(estimatedFees.descriptionFor12Digits) \(currencyModel.asset.nameOnlyForTransfer)"
            estimatedNormalCurrencyFees = estimatedFees
        }
    }

    var transferAmountType: TransferAmountView.ChangeCurrencyType = .balancToSend("0")
    var didUpdateBalanceFinished: (Bool) -> Void = {_ in }

    public init(with currencyModel: CurrencyModel, and addressTo: String = "") {
        self.addressTo = addressTo
        self.currencyModel = currencyModel
        self.shouldHideMinersFees = currencyModel.asset == .trx || currencyModel.asset == .usdtTrc20
        self.fixedTotalBalance = currencyModel.balance
        self.totalBalance = fixedTotalBalance.descriptionFor8Digits
        self.normalCurrencyBalance = "\(normalCurrencyCode)0.00"
    }
    
    func updatedBalance(with type: TransferAmountView.ChangeCurrencyType) {
        
        let ratio = coinRatioForTransfer?.yuan ?? 0
        self.transferAmountType = type
        switch type {
        case .all(let option):
            
            switch self.currencyModel.asset {
            case .usdtTrc20, .usdtErc20:
                balanceToSend = "\(fixedTotalBalance.getDescriptionDigits(by: currencyModel.asset))"
            default:
                var balance = fixedTotalBalance - estimatedFees
                balance = balance <= 0 ? 0 : balance
                balanceToSend = option == .toZero ? "" : "\((balance).getDescriptionDigits(by: currencyModel.asset))"
            }
            let normalBalance = (Double(balanceToSend) ?? 0) * ratio
            normalCurrencyBalance = normalBalance == 0 ? "\(normalCurrencyCode)0.00" : normalBalance.descriptionFor2Digits
            
        case .balancToSend(let balance):
            balanceToSend = "\(balance)"
            let normalBalance = (Double(balanceToSend) ?? 0) * ratio
            normalCurrencyBalance = normalBalance == 0 ? "\(normalCurrencyCode)0.00" : normalBalance.descriptionFor2Digits
            
        case .normalCurrency(let balance):
            normalCurrencyBalance = "\(normalCurrencyCode)\(balance)"
            balanceToSend = ((Double(balance) ?? 0) * ratio).getDescriptionDigits(by: currencyModel.asset)
        }
        
        didUpdateBalanceFinished(true)
    }
    
    func getGas(completionHandler: @escaping (Result<String>) -> Void) {
        
        SDKManager.shared.getGas(with: currencyModel.coinType) { [weak self] result in
            guard let self = self else { return }
            self.getPublicAddress()
            switch result {
            case .success(let data):
                let gasPrice = Double(data) ?? 0
                
                switch self.currencyModel.asset {
                case .btc:
                    self.gasFeesArry = [GasFeesPriorityModel(price: gasPrice + 0.000000002, type: .fast, isSelected: false, asset: .btc),
                                   GasFeesPriorityModel(price: gasPrice, type: .medium, isSelected: true, asset: .btc)]
                    self.getEstimaedFee(index: self.gasFeesArry.firstIndex(where: {$0.isSelected}) ?? 0, completionHandler: {_ in })
                case .eth, .usdtErc20:
                    self.gasFeesArry = [GasFeesPriorityModel(price: gasPrice + 0.000000004, type: .fast, isSelected: false, asset: .eth),
                                        GasFeesPriorityModel(price: gasPrice + 0.000000002, type: .medium, isSelected: true, asset: .eth),
                                   GasFeesPriorityModel(price: gasPrice, type: .slow, isSelected: false, asset: .eth)]
                    self.getEstimaedFee(index: self.gasFeesArry.firstIndex(where: {$0.isSelected}) ?? 0, completionHandler: {_ in })
                    
                default:
                    self.gasFeesArry = []
                }
                
               
               completionHandler(result)
               
            case .failure(let error):
                print("error...\(error)")
                completionHandler(result)
            }
        }
    }
    
    func getEstimaedFee(index: Int, comeFromRefreshed: Bool = false, completionHandler: @escaping (Result<String>) -> Void) {
      
        let gasFeesSelected = Double(truncating: self.gasFeesArry[index].price as NSNumber)
        SDKManager.shared.getEstimatedGas(with: currencyModel.coinType,
                                          and: gasFeesSelected) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let estimatedGas):
                for (currentIndex,item) in self.gasFeesArry.enumerated() {
                    if currentIndex == index {
                        item.isSelected = true
                    } else {
                        item.isSelected = false
                    }
                }
                self.gasFeesSelectedIndex = index
                self.estimatedFees = Double(estimatedGas) ?? 0
                
                if !comeFromRefreshed {
                    switch self.transferAmountType {
                    case .all(_):
                        self.updatedBalance(with: .all(.toZero))
                    default:
                        break // nothing to do
                    }
                }
                
                // here here here only if all
                completionHandler(.success(""))
            case .failure(let error):
                print("error getEstimatedGas...\(error)")
                completionHandler(.failure(error))
            }
        }
    }
    
    func validating(completionHandler: @escaping (Bool, ValidationMeesage) -> Void) {
        guard let address = addressTo, !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            completionHandler(false, .inputAddress)
            return
        }
        
        guard !balanceToSend.isEmpty && !(Double(balanceToSend) == 0) else {
            completionHandler(false, .inputTransferAmount)
            return
        }
        guard let balanceToSendValue = Double(balanceToSend), balanceToSendValue <= fixedTotalBalance else {
            completionHandler(false, .balanceNotEnough)
            return
        }
        
        /*
        guard balanceToSendValue >= estimatedFees else {
            completionHandler(false, .lessThanTransaction(balanceToSend + currencyModel.asset.name, estimatedFeesForDisplay))
            return
        }
        */
        
        guard !"\(estimatedFees)".isEmpty else {
            completionHandler(false, .checkEstimatedFee)
            return
        }
        
        completionHandler(true, .nothing)
    }
    
    func addNewtransfer(completionHandler: @escaping (Bool, String) -> Void) {
        
        guard let address = addressTo, !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            completionHandler(false, "transfer_please_input_address".localized)
            return
        }
        
        guard let balanceToSendValue = Double(balanceToSend), balanceToSendValue <= fixedTotalBalance else {
            completionHandler(false, "transfer_balance_not_enough".localized)
            return
        }
        
        
        let balanceToSendDouble =  balanceToSendValue
        let estimatedFeesDouble =  gasFeesArry.count == 0 ? 0 : gasFeesArry[gasFeesSelectedIndex].price

        DispatchQueue.global().async {[weak self] in
            guard let self = self else { return }
            SDKManager.shared.transfer(to: address, coinType: self.currencyModel.coinType,
                                       amount: balanceToSendDouble,
                                       gasPrice: estimatedFeesDouble) { result in
                
                DispatchQueue.main.async {
                    switch result {
                        
                    case.success(let data):
                        completionHandler(true, data)
                    case .failure(let error):
                        print("something wronge new transfer....\(error)")
                        switch error {
                        case .other(let meesage):
                            if meesage.contains("3005") {
                                let formatString = String(format: meesage.customLocalizedErrorMessage, self.estimatedFees.descriptionFor12Digits)
                                completionHandler(false, formatString)
                            } else { completionHandler(false, meesage.customLocalizedErrorMessage) }
                        default:
                            completionHandler(false, "something_wrong_try_again".localized)
                        }
                    }
                }
            }
        }
    }
    
    func getPublicAddress() {
        SDKManager.shared.getPublicAddress(with: currencyModel.coinType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.publicAddress = data
                
            case .failure(let error):
                print("something wronge when get public address \(error)")
            }
        }
    }
    
    func generatePaymentModel() -> PaymentModel {
        /*
         let balance = currencyModel.asset == .usdtErc20
         ? (Double(balanceToSend) ?? 0)
         : (Double(balanceToSend) ?? 0) - estimatedFees
         */
        let balance = (Double(balanceToSend) ?? 0)
        
        switch currencyModel.asset {
        case .trx, .usdtTrc20:
            return PaymentModel(balance: balance,
                                addressTo: addressTo ?? "",
                                addressFrom: publicAddress,
                                estimatedFees: 0,
                                priceFees: 0,
                                equation: "",
                                asset: currencyModel.asset)
        default:
            return PaymentModel(balance: balance,
                                addressTo: addressTo ?? "",
                                addressFrom: publicAddress,
                                estimatedFees: estimatedFees,
                                priceFees: gasFeesArry[gasFeesSelectedIndex].price,
                                equation: "≈Gas(\(currencyModel.minersFee))*Gas Price(\(gasFeesArry[gasFeesSelectedIndex].price.descriptionFor12Digits) \(currencyModel.asset.nameOnlyForTransfer))",
                                asset: currencyModel.asset)
        }
        
    }
    
    func getCoinRatio(completionHandler: @escaping (Bool) -> Void) {
        SDKManager.shared.getCoinRatio { [weak self] ratiosResult in
            guard let self = self else { return }
            switch ratiosResult {
            case .success(let ratios):
                self.coinRatioForTransfer = ratios.first(where: { return $0.coinType == self.currencyModel.coinType })
                
                self.coinRatioForMiner = ratios.first(where: {
                    let assetsEnumType = CurrencyAssetsEnum.getAssetsEnumType(by: self.currencyModel.coinType)
                    switch assetsEnumType {
                    case .usdtErc20: return CurrencyAssetsEnum.getAssetsEnumType(by: $0.coinType) == .eth
                    case .usdtTrc20: return CurrencyAssetsEnum.getAssetsEnumType(by: $0.coinType) == .trx
                    default: return $0.coinType == self.currencyModel.coinType
                    }
                })
                
                completionHandler(true)
            case .failure(let error):
                print("something wronge when fetch coinsRatio \(error)")
                completionHandler(false)
            }
        }
    }
}
