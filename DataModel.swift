
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
    
    func getUser(indexPath: NSIndexPath) -> User
    {
        return userdb[indexPath.row] as! User
    }
    
    // MARK: - CRUD
    
    func saveUser(fName: String, lName: String, uEmail: String, pWd1:String, pWd2:String)->Bool
    {
        // Create a new managed object and insert it into the context, so it can be saved into the database
        let entity =  NSEntityDescription.entityForName("User", inManagedObjectContext:managedContext)
        
        //prepre for input validation
        let error = NSErrorPointer()
        let fetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email == %@", uEmail)
        let fetchResults = managedContext.countForFetchRequest(fetchRequest, error: error)
        
        //check if fields are empty
        if(fName.isEmpty || lName.isEmpty || uEmail.isEmpty || pWd1.isEmpty || pWd2.isEmpty)
        {
            displayMyAlertMessage("All fields are required")
            return false
        }
        //check if passwords equal
        else if(pWd1 != pWd2)
        {
            displayMyAlertMessage("Passwords do not match")
            return false
        }
        //check if user already exists
        else if(fetchResults > 0)
        {
            displayMyAlertMessage("User is already registered")
            return false
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
            print("here")
            updateDatabase()
            print("here - 2")
            return true
        }
    }

    //validate logIn detials are correct
    func validateLogIn(uEmail : String, password : String) ->Bool
    {
        //check for empty fields
        if(uEmail.isEmpty || password.isEmpty)
        {
            displayMyAlertMessage("All fields are required")
            return false
        }
        else
        {
            //check username and password match records
            let predicate = NSPredicate (format:"email = %@" ,uEmail)
            let fetchRequest = NSFetchRequest ( entityName: "User")
            fetchRequest.predicate = predicate
            let fetchResult = try! self.managedContext.executeFetchRequest(fetchRequest) as! [User]
            if fetchResult.count>0
            {
                let objectEntity : User = fetchResult.first! as User
                if objectEntity.email == uEmail && objectEntity.password == password
                {
                    return true   // Entered email & password matched
                }
                else
                {
                    print("fail")
                    displayMyAlertMessage("Username and password combination incorrect")
                    return false  //Wrong password/email
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





