//
//  AppDependency.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit
@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxOptional
@_exported import RxSwiftExt
@_exported import NSObject_Rx
@_exported import RxDataSources
@_exported import RxViewController
@_exported import RxTheme
@_exported import Moya
@_exported import Cache
@_exported import BonMot
@_exported import QMUIKit
@_exported import ReactorKit
@_exported import ReusableKit
@_exported import ObjectMapper
@_exported import URLNavigator
@_exported import Rswift
@_exported import Kingfisher
@_exported import SwifterSwift
@_exported import SwiftEntryKit
@_exported import CocoaLumberjack
@_exported import IQKeyboardManagerSwift
@_exported import Toast_Swift
@_exported import Umbrella
@_exported import SWFrame

final class AppDependency: AppDependencyType {

    let navigator: NavigatorType
    let provider: SWFrame.ProviderType
    let disposeBag = DisposeBag()
    var window: UIWindow!
    
    static var shared = AppDependency()

    // MARK: - Initialize
    init() {
        self.navigator = Navigator.init()
        self.provider = Provider.init()
    }

    func initialScreen(with window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        self.window = window

        let reactor = TabBarReactor(self.provider, nil)
        let controller = TabBarController(self.navigator, reactor)
        self.window.rootViewController = controller
        self.window.makeKeyAndVisible()
    }
    
    // MARK: - Test
    func test(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
    }
    
    // MARK: - Lifecycle
    func application(
        _ application: UIApplication,
        entryDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        Runtime.work()
        Library.setup()
        Appearance.config()
        Router.initialize(self.provider, self.navigator)
    }

    func application(
        _ application: UIApplication,
        leaveDidFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        if UIApplication.shared.channel == .develop {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.test(launchOptions: launchOptions)
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - URL
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any]
    ) -> Bool {
        return true
    }

    // MARK: - userActivity
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        return true
    }
    
}
