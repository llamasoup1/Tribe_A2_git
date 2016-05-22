//
//  LogInViewController
//  Tribe
//

import UIKit
import CoreData
import FBSDKLoginKit

class LogInViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var model:Model = Model.sharedInstance


    @IBAction func logIn(sender:  UIButton) {
        //validate login, if successful proceed
        if Model.sharedInstance.validateLogIn(emailField.text!, password: passwordField.text!) == true{
            self.performSegueWithIdentifier("logIn" ,sender:sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
    }

    
        
}

    


