import React
import SwiftUI

/// Bridge module:
/// - Push-style: if root is a UINavigationController, pushes onto it; else presents full-screen (no custom transition).
/// - Modal-style: presents .pageSheet.
@objc(NativeScreenModule)
final class NativeScreenModule: NSObject {

  private static var keyWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap(\.windows)
      .first { $0.isKeyWindow }
  }

  @objc
  static func requiresMainQueueSetup() -> Bool { false }

  @objc
  func openNativeScreen(_ title: String, callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async { [weak self] in
      self?.pushUIKitScreen(title: title, callback: callback)
    }
  }

  @objc
  func openNativeSwiftUIScreen(_ title: String, callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async { [weak self] in
      self?.pushSwiftUIScreen(title: title, callback: callback)
    }
  }

  @objc
  func openNativeModalScreen(_ title: String, callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async { [weak self] in
      self?.presentUIKitModalScreen(title: title, callback: callback)
    }
  }

  @objc
  func openNativeSwiftUIModalScreen(_ title: String, callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async { [weak self] in
      self?.presentSwiftUIModalScreen(title: title, callback: callback)
    }
  }

  /// Push-style: push if root is UINavigationController; otherwise present full-screen (system animation).
  private func pushUIKitScreen(title: String, callback: @escaping RCTResponseSenderBlock) {
    let rootVC = Self.keyWindow?.rootViewController
    guard let rootVC else {
      callback([["error": "No root view controller"]])
      return
    }
    if let nav = rootVC as? UINavigationController {
      let vc = NativeExampleViewController(title: title) { [weak nav] in
        nav?.popViewController(animated: true)
      }
      vc.onPopCallback = { callback([]) }
      nav.pushViewController(vc, animated: true)
      return
    }
    let vc = NativeExampleViewController(title: title) { [weak rootVC] in
      callback([])
      rootVC?.dismiss(animated: true)
    }
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
    rootVC.present(nav, animated: true)
  }

  /// Push-style: push if root is UINavigationController; otherwise present full-screen (system animation).
  private func pushSwiftUIScreen(title: String, callback: @escaping RCTResponseSenderBlock) {
    let rootVC = Self.keyWindow?.rootViewController
    guard let rootVC else {
      callback([["error": "No root view controller"]])
      return
    }
    if let nav = rootVC as? UINavigationController {
      let hosting = PushableHostingController(
        rootView: NativeExampleSwiftUIView(title: title) { [weak nav] in
          nav?.popViewController(animated: true)
        }
      )
      hosting.onPopCallback = { callback([]) }
      nav.pushViewController(hosting, animated: true)
      return
    }
    let swiftUIView = NativeExampleSwiftUIView(title: title) {
      callback([])
      rootVC.dismiss(animated: true)
    }
    let hosting = UIHostingController(rootView: swiftUIView)
    hosting.modalPresentationStyle = .fullScreen
    rootVC.present(hosting, animated: true)
  }

  private func presentUIKitModalScreen(title: String, callback: @escaping RCTResponseSenderBlock) {
    let rootVC = Self.keyWindow?.rootViewController
    guard let rootVC else {
      callback([["error": "No root view controller"]])
      return
    }
    let vc = NativeExampleViewController(title: title) { [weak rootVC] in
      callback([])
      rootVC?.dismiss(animated: true)
    }
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .pageSheet
    if #available(iOS 15.0, *) {
      nav.sheetPresentationController?.detents = [.medium(), .large()]
      nav.sheetPresentationController?.prefersGrabberVisible = true
    }
    rootVC.present(nav, animated: true)
  }

  private func presentSwiftUIModalScreen(title: String, callback: @escaping RCTResponseSenderBlock) {
    let rootVC = Self.keyWindow?.rootViewController
    guard let rootVC else {
      callback([["error": "No root view controller"]])
      return
    }
    let swiftUIView = NativeExampleSwiftUIView(title: title) {
      callback([])
      rootVC.dismiss(animated: true)
    }
    let hosting = UIHostingController(rootView: swiftUIView)
    hosting.modalPresentationStyle = .pageSheet
    if #available(iOS 15.0, *) {
      hosting.sheetPresentationController?.detents = [.medium(), .large()]
      hosting.sheetPresentationController?.prefersGrabberVisible = true
    }
    rootVC.present(hosting, animated: true)
  }
}

// MARK: - Pushable SwiftUI hosting (calls onPop when popped by swipe-back or back button)
private final class PushableHostingController: UIHostingController<NativeExampleSwiftUIView> {

  var onPopCallback: (() -> Void)?

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if isMovingFromParent {
      onPopCallback?()
    }
  }
}
