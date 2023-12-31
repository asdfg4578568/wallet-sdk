// Objective-C API for talking to Share-Wallet/cmd/wallet-sdk-core/cold-wallet Go package.
//   gobind -lang=objc Share-Wallet/cmd/wallet-sdk-core/cold-wallet
//
// File is generated by gobind. Do not edit.

#ifndef __Cold_wallet_H__
#define __Cold_wallet_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"


/**
 * AddAddressBook func add address and  name to local db
 */
FOUNDATION_EXPORT BOOL Cold_walletAddAddressBook(long coinType, NSString* _Nullable address, NSString* _Nullable name, BOOL* _Nullable result, NSError* _Nullable* _Nullable error);

/**
 * CheckUserExist func fetches seed phrase in random order.
 */
FOUNDATION_EXPORT BOOL Cold_walletCheckUserExist(NSString* _Nullable userID);

/**
 * DeleteAddressBook func deletes address book
 */
FOUNDATION_EXPORT BOOL Cold_walletDeleteAddressBook(long coinType, NSString* _Nullable address);

/**
 * FetchLocalCoins func fetches coin list
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletFetchLocalCoins(void);

/**
 * FetchSeedPhraseRandom func fetches seed phrase in random order.
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletFetchSeedPhraseRandom(NSError* _Nullable* _Nullable error);

/**
 * FetchSeedPhraseWord func returns seed phrase word suggestions.
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletFetchSeedPhraseWord(NSString* _Nullable word);

/**
 * GenerateSeedPhrase func generates seed phrase for userID.
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGenerateSeedPhrase(NSString* _Nullable lang, NSString* _Nullable secret, NSError* _Nullable* _Nullable error);

/**
 * GenerateUserAccount func calls setpasscode,generateseedphrase and register account then return seed phrase
 Supported languages (lang)
//	EN    = "en"
//	CHSim = "ch-sim"
//	CHTra = "ch-tra"
//	FR    = "fr"
//	IT    = "it"
//	JA    = "ja"
//	KO    = "ko"
//	SP    = "sp"
//
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGenerateUserAccount(NSString* _Nullable lang, NSString* _Nullable secret, NSError* _Nullable* _Nullable error);

/**
 * GetLocalUserAddressBook func returns addressbook
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGetLocalUserAddressBook(long coinType);

/**
 * GetLocalUserAddressBook func returns addressbook
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGetLocalUserAddressBookByAddress(long coinType, NSString* _Nullable address);

/**
 * GetUser func fetches user sensitive data.
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGetUserPrivateKey(NSString* _Nullable secret, long coinType, long keyType);

/**
 * GetUser func fetches user sensitive data.
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletGetUserSeedPhrase(NSString* _Nullable secret);

/**
 * GetUserStatus func fetches the status of user.
 */
FOUNDATION_EXPORT long Cold_walletGetUserStatus(void);

/**
 * InitWalletSDK func initialise the sdk with database connection.
 */
FOUNDATION_EXPORT BOOL Cold_walletInitWalletSDK(NSString* _Nullable userID, NSString* _Nullable config);

/**
 * RecoverUserAccount func calls setpasscode,register account.
 */
FOUNDATION_EXPORT BOOL Cold_walletRecoverUserAccount(NSString* _Nullable secret, NSString* _Nullable seedPhrase, BOOL* _Nullable ret0_, NSError* _Nullable* _Nullable error);

/**
 * SDKVersion func returns SDK version
 */
FOUNDATION_EXPORT NSString* _Nonnull Cold_walletSDKVersion(void);

/**
 * SetPasscode func set passcode for login userID and returns true if success.
accountType: 1 create, 2 recover
 */
FOUNDATION_EXPORT BOOL Cold_walletSetPasscode(NSString* _Nullable Password, long accountType, BOOL* _Nullable ret0_, NSError* _Nullable* _Nullable error);

/**
 * SynchronizeUserAccount func creates account information in server
 */
FOUNDATION_EXPORT BOOL Cold_walletSynchronizeUserAccount(NSString* _Nullable userID, NSString* _Nullable publicKey);

FOUNDATION_EXPORT NSString* _Nonnull Cold_walletTestCold(void);

/**
 * VerifyPasscode func verify passcode for userID and returns true if success.
 */
FOUNDATION_EXPORT BOOL Cold_walletVerifyPasscode(NSString* _Nullable Password);

/**
 * VerifySeedPharse func verify seed phrase for userID.
 */
FOUNDATION_EXPORT BOOL Cold_walletVerifySeedPharse(NSString* _Nullable userID, NSString* _Nullable seed, BOOL* _Nullable ret0_, NSError* _Nullable* _Nullable error);

#endif
