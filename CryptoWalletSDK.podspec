#
# Be sure to run `pod lib lint CryptoWalletSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'CryptoWalletSDK'
    s.version          = '0.1.0'
    s.summary          = 'Description of CryptoWalletSDK.'
    
    s.homepage         = 'http://192.168.0.251/supersign/crypto-wallet/ios_sdk.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    #s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Developer_IOS_Shahrouj' => 'shahrouj@peakperformances.io' }
    s.source           = { :git => 'http://192.168.0.251/supersign/crypto-wallet/ios_sdk.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '13.0'
    s.source_files = ['**/*.{swift}', '**/*.{strings}']
    s.vendored_frameworks = 'WalletSdkCore.xcframework'
    
    
    s.resource_bundles = {
        'CryptoWalletSDK' => ['**/*.png', '**/*.{json}', '**/*.{xcassets}', '**/*.lproj/*.strings', '**/*.{ttf}']
    }
    
    s.dependency 'SnapKit'
    s.dependency 'XLPagerTabStrip'
    s.dependency 'SwipeCellKit'
    s.dependency 'ToastViewSwift', '2.1.1'
    s.dependency 'Localize-Swift'
end
