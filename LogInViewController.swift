//
//  LogInViewController
//  Tribe
//

import UIKit
import CoreData

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
    
        
}

    


