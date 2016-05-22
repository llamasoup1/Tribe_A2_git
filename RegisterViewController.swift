//
//  RegisterViewController
//  Tribe
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var lastnameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    
    var model:Model = Model.sharedInstance

    //Register user
    @IBAction func register(sender: UIButton) {
        
        Model.sharedInstance.saveUser(firstnameField.text!, lName: lastnameField.text!, uEmail: emailField.text!, pWd1: passwordField.text!, pWd2: confirmPasswordField.text!)
    }


    //display UIAlert
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"Alert", message:
            userMessage, preferredStyle:
            UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"Ok", style:
            UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated:true,
            completion:nil)
        
    }
    


    
}
