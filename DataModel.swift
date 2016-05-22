
import Foundation
import CoreData
import UIKit
class Model
{
    
    
    // Get a reference to your App Delegate
    let appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Get a database context from the app delegate
    var managedContext: NSManagedObjectContext
        {
        get{
            return appDelegate.managedObjectContext
        }
    }
    
    
    // Create a collection of objects to store in the database
    var userdb = [NSManagedObject]()
    
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        return window}()
    
    func getUser(indexPath: NSIndexPath) -> User
    {
        return userdb[indexPath.row] as! User
    }
    
    // MARK: - CRUD
    
    func saveUser(fName: String, lName: String, uEmail: String, pWd1:String, pWd2:String)
    {
        // Create a new managed object and insert it into the context, so it can be saved into the database
        let entity =  NSEntityDescription.entityForName("User",
            inManagedObjectContext:managedContext)
        //prepre for input validation
        let error = NSErrorPointer()
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", uEmail)
        let fetchResults = managedContext.countForFetchRequest(fetchRequest, error: error)
        //*****let viewController = alertWindow.rootViewController*****
        //******print(viewController)*****
        //check if fields are empty
        if(fName.isEmpty || lName.isEmpty || uEmail.isEmpty || pWd1.isEmpty || pWd2.isEmpty)
        {
            print("ERROR 1")
            displayMyAlertMessage("All fields are required")
            return
        }
        //check if passwords equal
        else if(pWd1 != pWd2)
        {
            print("ERROR 2")
            displayMyAlertMessage("Passwords do not match")
            return
        }
        //check if user already exists
        else if(fetchResults > 0)
        {
            print("ERROR 3")
            displayMyAlertMessage("User is already registered")
            return
        }
        //if all requirements met, create an object based on the entity
        else
        {
            let user = User(entity: entity!,
                insertIntoManagedObjectContext:managedContext)
            user.firstname = fName
            user.lastname = lName
            user.email = uEmail
            user.password = pWd1
            
            updateDatabase()
            //this line of code required to segue manually to next page!
            //*********viewController.performSegueWithIdentifier("register" ,sender:self)******
        }
        
    }

    
    func validateLogIn(uEmail : String, password : String) ->Bool
    {
        print("here")
        let viewController = alertWindow.rootViewController
        if(uEmail.isEmpty || password.isEmpty)
        {
            print("ERROR 1")
            displayMyAlertMessage("All fields are required")
            return false
        }
        else
        {
            let predicate = NSPredicate (format:"email = %@" ,uEmail)
            let fetchRequest = NSFetchRequest ( entityName: "User")
            fetchRequest.predicate = predicate
            let fetchResult = try! self.managedContext.executeFetchRequest(fetchRequest) as! [User]
        
            if fetchResult.count>0
            {
                let objectEntity : User = fetchResult.first! as User
                if objectEntity.email == uEmail && objectEntity.password == password
                {
                
                    print("login")
                    viewController?.performSegueWithIdentifier("registration" ,sender:viewController)
                    return true   // Entered Username & password matched
                }
                else
                {
                    print("fail")
                    displayMyAlertMessage("Username and password combination incorrect")
                    return false  //Wrong password/username
                }
            }
        }

            return false
    }
    
    
    
    func getUsers()
    {
        do
        {
            let fetchRequest = NSFetchRequest(entityName:"User")
            
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            userdb = results as! [User]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    // Save the current state of the objects in the managed context into the database.
    func updateDatabase()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    //display UIAlert
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = AlertController(title:"Oops!", message:
            userMessage, preferredStyle:
            UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title:"Ok", style:
            UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)

        myAlert.show()
    }
    
    // Struct to hold the instance of the model
    private struct Static
    {
        static var instance: Model?
    }
    
    
    class var sharedInstance: Model
    {
        if (Static.instance == nil)
        {
            Static.instance = Model()
        }
        return Static.instance!
    }
    
}



