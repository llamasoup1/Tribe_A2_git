//
//  AlertController
//  Tribe
//

import UIKit

public class AlertController: UIAlertController {
    
    // The UIWindow that will be at the top of the window hierarchy. The AlertController instance is presented on the rootViewController of this window.
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = ClearViewController()
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = UIWindowLevelAlert
        return window
    }()
    
    
    //Present the AlertController on top of the visible UIViewController.
    public func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            
            rootViewController.presentViewController(self, animated: flag, completion: nil)
        }
    }
    
}

// In the case of view controller-based status bar style, make sure we use the same style for our view controller
private class ClearViewController: UIViewController {
    
    private override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIApplication.sharedApplication().statusBarStyle
    }
    
    private override func prefersStatusBarHidden() -> Bool {
        return UIApplication.sharedApplication().statusBarHidden
    }
    
}
