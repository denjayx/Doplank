//
//  AppOrientation.swift
//  Doplank
//
//  Updated orientation lock manager using non-deprecated rotation update APIs.
//

import UIKit

enum AppOrientation {
    /// App-wide default orientation behavior.
    static let defaultMask: UIInterfaceOrientationMask = .portrait

    /// Current mutable orientation mask used by AppDelegate.
    private(set) static var currentMask: UIInterfaceOrientationMask = defaultMask

    /// Lock to portrait and rotate immediately.
    static func lockPortrait() {
        lock(.portrait)
    }

    /// Lock to landscape and rotate immediately.
    static func lockLandscape() {
        lock(.landscape)
    }

    /// Generic lock method.
    static func lock(_ mask: UIInterfaceOrientationMask) {
        currentMask = mask
        applyGeometry(mask: mask)
    }

    /// Restore default orientation behavior.
    static func unlockToDefault() {
        currentMask = defaultMask
        applyGeometry(mask: defaultMask)
    }

    private static func applyGeometry(mask: UIInterfaceOrientationMask) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        if #available(iOS 16.0, *) {
            scene.requestGeometryUpdate(.iOS(interfaceOrientations: mask)) { _ in }
        }

        // Non-deprecated refresh path (replaces attemptRotationToDeviceOrientation()).
        scene.windows.forEach { window in
            window.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}

/// AppDelegate bridge for supported orientations in SwiftUI app lifecycle.
final class AppOrientationDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        AppOrientation.currentMask
    }
}
