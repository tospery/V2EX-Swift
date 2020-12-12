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

  /// This `R.file` struct is generated, and contains static references to 7 files.
  struct file {
    /// Resource file `NodesAll.json`.
    static let nodesAllJson = Rswift.FileResource(bundle: R.hostingBundle, name: "NodesAll", pathExtension: "json")
    /// Resource file `Signin.html`.
    static let signinHtml = Rswift.FileResource(bundle: R.hostingBundle, name: "Signin", pathExtension: "html")
    /// Resource file `Signin_failure_captcha.html`.
    static let signin_failure_captchaHtml = Rswift.FileResource(bundle: R.hostingBundle, name: "Signin_failure_captcha", pathExtension: "html")
    /// Resource file `SiteInfo.json`.
    static let siteInfoJson = Rswift.FileResource(bundle: R.hostingBundle, name: "SiteInfo", pathExtension: "json")
    /// Resource file `SiteStats.json`.
    static let siteStatsJson = Rswift.FileResource(bundle: R.hostingBundle, name: "SiteStats", pathExtension: "json")
    /// Resource file `TopicsHot.json`.
    static let topicsHotJson = Rswift.FileResource(bundle: R.hostingBundle, name: "TopicsHot", pathExtension: "json")
    /// Resource file `TopicsLatest.json`.
    static let topicsLatestJson = Rswift.FileResource(bundle: R.hostingBundle, name: "TopicsLatest", pathExtension: "json")

    /// `bundle.url(forResource: "NodesAll", withExtension: "json")`
    static func nodesAllJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.nodesAllJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Signin", withExtension: "html")`
    static func signinHtml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.signinHtml
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Signin_failure_captcha", withExtension: "html")`
    static func signin_failure_captchaHtml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.signin_failure_captchaHtml
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

    /// `bundle.url(forResource: "TopicsHot", withExtension: "json")`
    static func topicsHotJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.topicsHotJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "TopicsLatest", withExtension: "json")`
    static func topicsLatestJson(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.topicsLatestJson
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 13 images.
  struct image {
    /// Image `app_icon`.
    static let app_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "app_icon")
    /// Image `app_logo`.
    static let app_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "app_logo")
    /// Image `captcha_failed`.
    static let captcha_failed = Rswift.ImageResource(bundle: R.hostingBundle, name: "captcha_failed")
    /// Image `captcha_loading`.
    static let captcha_loading = Rswift.ImageResource(bundle: R.hostingBundle, name: "captcha_loading")
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
    /// Image `weixin`.
    static let weixin = Rswift.ImageResource(bundle: R.hostingBundle, name: "weixin")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "app_icon", bundle: ..., traitCollection: ...)`
    static func app_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.app_icon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "app_logo", bundle: ..., traitCollection: ...)`
    static func app_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.app_logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "captcha_failed", bundle: ..., traitCollection: ...)`
    static func captcha_failed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.captcha_failed, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "captcha_loading", bundle: ..., traitCollection: ...)`
    static func captcha_loading(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.captcha_loading, compatibleWith: traitCollection)
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

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "weixin", bundle: ..., traitCollection: ...)`
    static func weixin(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.weixin, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 28 localization keys.
    struct localizable {
      /// Value: 创意工作者们的社区
      static let slogan = Rswift.StringResource(key: "Slogan", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 否
      static let no = Rswift.StringResource(key: "No", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 和
      static let and = Rswift.StringResource(key: "And", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 密码
      static let password = Rswift.StringResource(key: "Password", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 开始使用
      static let getStarted = Rswift.StringResource(key: "Get Started", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
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
      /// Value: 服务条款
      static let termsOfService = Rswift.StringResource(key: "Terms of service", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 用户名
      static let username = Rswift.StringResource(key: "Username", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 登录
      static let login = Rswift.StringResource(key: "Login", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 登录即表示您已阅读并同意%@和%@
      static let loginTerm = Rswift.StringResource(key: "Login.Term", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 登录失败，请稍后重试
      static let errorLogin = Rswift.StringResource(key: "Error.Login", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
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
      /// Value: 隐私政策
      static let privacyAgreement = Rswift.StringResource(key: "Privacy agreement", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 非法操作
      static let errorIllegalMessage = Rswift.StringResource(key: "Error.Illegal.Message", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 首页
      static let home = Rswift.StringResource(key: "Home", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: 验证码
      static let captcha = Rswift.StringResource(key: "Captcha", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: 创意工作者们的社区
      static func slogan(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Slogan", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Slogan"
        }

        return NSLocalizedString("Slogan", bundle: bundle, comment: "")
      }

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

      /// Value: 和
      static func and(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("And", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "And"
        }

        return NSLocalizedString("And", bundle: bundle, comment: "")
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

      /// Value: 开始使用
      static func getStarted(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Get Started", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Get Started"
        }

        return NSLocalizedString("Get Started", bundle: bundle, comment: "")
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

      /// Value: 服务条款
      static func termsOfService(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Terms of service", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Terms of service"
        }

        return NSLocalizedString("Terms of service", bundle: bundle, comment: "")
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

      /// Value: 登录即表示您已阅读并同意%@和%@
      static func loginTerm(_ value1: String, _ value2: String, preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          let format = NSLocalizedString("Login.Term", bundle: hostingBundle, comment: "")
          return String(format: format, locale: applicationLocale, value1, value2)
        }

        guard let (locale, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Login.Term"
        }

        let format = NSLocalizedString("Login.Term", bundle: bundle, comment: "")
        return String(format: format, locale: locale, value1, value2)
      }

      /// Value: 登录失败，请稍后重试
      static func errorLogin(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Error.Login", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Error.Login"
        }

        return NSLocalizedString("Error.Login", bundle: bundle, comment: "")
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

      /// Value: 隐私政策
      static func privacyAgreement(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("Privacy agreement", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "Privacy agreement"
        }

        return NSLocalizedString("Privacy agreement", bundle: bundle, comment: "")
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
