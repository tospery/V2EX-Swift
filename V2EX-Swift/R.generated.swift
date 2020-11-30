//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `Signin.html`.
    static let signinHtml = Rswift.FileResource(bundle: R.hostingBundle, name: "Signin", pathExtension: "html")
    /// Resource file `SiteInfo.json`.
    static let siteInfoJson = Rswift.FileResource(bundle: R.hostingBundle, name: "SiteInfo", pathExtension: "json")
    /// Resource file `SiteStats.json`.
    static let siteStatsJson = Rswift.FileResource(bundle: R.hostingBundle, name: "SiteStats", pathExtension: "json")

    /// `bundle.url(forResource: "Signin", withExtension: "html")`
    static func signinHtml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.signinHtml
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SiteInfo", withExtension: "json")`
    static func siteInfoJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.siteInfoJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "SiteStats", withExtension: "json")`
    static func siteStatsJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.siteStatsJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 9 images.
  struct image {
    /// Image `app_logo`.
    static let app_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "app_logo")
    /// Image `login_account`.
    static let login_account = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_account")
    /// Image `login_bg`.
    static let login_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_bg")
    /// Image `login_captcha`.
    static let login_captcha = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_captcha")
    /// Image `login_password`.
    static let login_password = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_password")
    /// Image `tabbar_home_normal`.
    static let tabbar_home_normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_home_normal")
    /// Image `tabbar_home_selected`.
    static let tabbar_home_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_home_selected")
    /// Image `tabbar_mine_normal`.
    static let tabbar_mine_normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_mine_normal")
    /// Image `tabbar_mine_selected`.
    static let tabbar_mine_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_mine_selected")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "app_logo", bundle: ..., traitCollection: ...)`
    static func app_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.app_logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "login_account", bundle: ..., traitCollection: ...)`
    static func login_account(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_account, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "login_bg", bundle: ..., traitCollection: ...)`
    static func login_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_bg, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "login_captcha", bundle: ..., traitCollection: ...)`
    static func login_captcha(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_captcha, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "login_password", bundle: ..., traitCollection: ...)`
    static func login_password(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_password, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_home_normal", bundle: ..., traitCollection: ...)`
    static func tabbar_home_normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_home_normal, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_home_selected", bundle: ..., traitCollection: ...)`
    static func tabbar_home_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_home_selected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_mine_normal", bundle: ..., traitCollection: ...)`
    static func tabbar_mine_normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_mine_normal, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_mine_selected", bundle: ..., traitCollection: ...)`
    static func tabbar_mine_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_mine_selected, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 21 localization keys.
    struct localizable {
      /// Value: 否
      static let no = Rswift.StringResource(key: "No", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 密码
      static let password = Rswift.StringResource(key: "Password", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 当前账户登录已过期，请重新登录
      static let errorExpiredMessage = Rswift.StringResource(key: "Error.Expired.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 我的
      static let mine = Rswift.StringResource(key: "Mine", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 数据为空
      static let errorEmptyMessage = Rswift.StringResource(key: "Error.Empty.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 无效的数据格式
      static let errorInvalidFormat = Rswift.StringResource(key: "Error.InvalidFormat", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 是
      static let yes = Rswift.StringResource(key: "Yes", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 服务异常
      static let errorServerMessage = Rswift.StringResource(key: "Error.Server.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 用户名
      static let username = Rswift.StringResource(key: "Username", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 登录
      static let login = Rswift.StringResource(key: "Login", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 确定
      static let oK = Rswift.StringResource(key: "OK", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 确定
      static let sure = Rswift.StringResource(key: "Sure", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 网络错误
      static let errorNetworkMessage = Rswift.StringResource(key: "Error.Network.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 重试
      static let errorEmptyTitle = Rswift.StringResource(key: "Error.Empty.Title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 重试
      static let errorExpiredTitle = Rswift.StringResource(key: "Error.Expired.Title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 重试
      static let errorIllegalTitle = Rswift.StringResource(key: "Error.Illegal.Title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 重试
      static let errorNetworkTitle = Rswift.StringResource(key: "Error.Network.Title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 重试
      static let errorServerTitle = Rswift.StringResource(key: "Error.Server.Title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 非法操作
      static let errorIllegalMessage = Rswift.StringResource(key: "Error.Illegal.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 首页
      static let home = Rswift.StringResource(key: "Home", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 验证码
      static let captcha = Rswift.StringResource(key: "Captcha", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: 否
      static func no(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("No", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "No"
        }

        return NSLocalizedString("No", bundle: bundle, comment: "")
      }

      /// Value: 密码
      static func password(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Password", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Password"
        }

        return NSLocalizedString("Password", bundle: bundle, comment: "")
      }

      /// Value: 当前账户登录已过期，请重新登录
      static func errorExpiredMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Expired.Message", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Expired.Message"
        }

        return NSLocalizedString("Error.Expired.Message", bundle: bundle, comment: "")
      }

      /// Value: 我的
      static func mine(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Mine", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Mine"
        }

        return NSLocalizedString("Mine", bundle: bundle, comment: "")
      }

      /// Value: 数据为空
      static func errorEmptyMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Empty.Message", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Empty.Message"
        }

        return NSLocalizedString("Error.Empty.Message", bundle: bundle, comment: "")
      }

      /// Value: 无效的数据格式
      static func errorInvalidFormat(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.InvalidFormat", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.InvalidFormat"
        }

        return NSLocalizedString("Error.InvalidFormat", bundle: bundle, comment: "")
      }

      /// Value: 是
      static func yes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Yes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Yes"
        }

        return NSLocalizedString("Yes", bundle: bundle, comment: "")
      }

      /// Value: 服务异常
      static func errorServerMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Server.Message", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Server.Message"
        }

        return NSLocalizedString("Error.Server.Message", bundle: bundle, comment: "")
      }

      /// Value: 用户名
      static func username(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Username", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Username"
        }

        return NSLocalizedString("Username", bundle: bundle, comment: "")
      }

      /// Value: 登录
      static func login(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Login", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Login"
        }

        return NSLocalizedString("Login", bundle: bundle, comment: "")
      }

      /// Value: 确定
      static func oK(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("OK", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "OK"
        }

        return NSLocalizedString("OK", bundle: bundle, comment: "")
      }

      /// Value: 确定
      static func sure(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Sure", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Sure"
        }

        return NSLocalizedString("Sure", bundle: bundle, comment: "")
      }

      /// Value: 网络错误
      static func errorNetworkMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Network.Message", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Network.Message"
        }

        return NSLocalizedString("Error.Network.Message", bundle: bundle, comment: "")
      }

      /// Value: 重试
      static func errorEmptyTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Empty.Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Empty.Title"
        }

        return NSLocalizedString("Error.Empty.Title", bundle: bundle, comment: "")
      }

      /// Value: 重试
      static func errorExpiredTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Expired.Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Expired.Title"
        }

        return NSLocalizedString("Error.Expired.Title", bundle: bundle, comment: "")
      }

      /// Value: 重试
      static func errorIllegalTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Illegal.Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Illegal.Title"
        }

        return NSLocalizedString("Error.Illegal.Title", bundle: bundle, comment: "")
      }

      /// Value: 重试
      static func errorNetworkTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Network.Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Network.Title"
        }

        return NSLocalizedString("Error.Network.Title", bundle: bundle, comment: "")
      }

      /// Value: 重试
      static func errorServerTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Server.Title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Server.Title"
        }

        return NSLocalizedString("Error.Server.Title", bundle: bundle, comment: "")
      }

      /// Value: 非法操作
      static func errorIllegalMessage(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Illegal.Message", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Illegal.Message"
        }

        return NSLocalizedString("Error.Illegal.Message", bundle: bundle, comment: "")
      }

      /// Value: 首页
      static func home(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Home", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Home"
        }

        return NSLocalizedString("Home", bundle: bundle, comment: "")
      }

      /// Value: 验证码
      static func captcha(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Captcha", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Captcha"
        }

        return NSLocalizedString("Captcha", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
