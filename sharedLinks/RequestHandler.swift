//
//  Request Handler - Links
//  Tribe
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class RequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequestWithExtensionContext(context: NSExtensionContext) {
        
        var arr = [NSExtensionItem]()
        let extensionItem = NSExtensionItem()
        let todayDate = NSDate()
        let todayFormat = dateFormatter(todayDate)
        
        Alamofire.request(.GET, "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=\(todayFormat)&endDate=\(todayFormat)&order=popularity&resultsPerPage=1&pages=1").responseJSON {(responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            if let resData = swiftyJsonVar["data"].arrayObject {
                for value in resData{
                    let dict = value as! NSDictionary
                    let title = dict["title"] as? String
                    let bookingLink = dict["venues"]?[0]?["performances"]?![0]?["sourceUrl"] as? String
                    //let image = dict["venues"]?[0]?["image"]?![0]?["lowResolution"] as? String
                    let id = dict["categories"]?[0]?["id"] as? Int
            
                   extensionItem.userInfo = [ "uniqueIdentifier": id!, "urlString": bookingLink!, "date": NSDate() ]
                   extensionItem.attributedTitle = NSAttributedString(string: "Event of the week")
                   extensionItem.attributedContentText = NSAttributedString(string: title!)
                 //  let url = NSURL(string: bookingLink!)!
                    arr.append(extensionItem)
                    
                   // extensionItem.attachments = NSItemProvider(contentsOfURL: url)
                }
                context.completeRequestReturningItems([extensionItem], completionHandler: nil)
                
            }
        
        }
    }
    //format date for use in API
    func dateFormatter(date: NSDate)-> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let convertedDate = formatter.stringFromDate(date)
        return convertedDate
    }
    

}
