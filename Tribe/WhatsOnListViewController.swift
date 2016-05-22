//
//  WhatsOnListController.swift
//  Tribe
//
import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class WhatsOnListController: UIViewController {
    
    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    var apiLink = "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=2016-05-22&endDate=2016-05-22"

    //change date for each segment control press
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBAction func segAction(sender: UISegmentedControl) {
        let todayDate = NSDate()
        let tomorrowDate = todayDate.dateByAddingTimeInterval(60*60*24)
        let todayFormat = dateFormatter(todayDate)
        let tomorrowFormat = dateFormatter(tomorrowDate)
        
        switch segControl.selectedSegmentIndex
        {
        case 0:
            apiLink = "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=\(todayFormat)&endDate=\(todayFormat)"
            print(apiLink)
            apiRequest()
        case 1:
            apiLink = "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=\(tomorrowFormat)&endDate=\(tomorrowFormat)"
            print(apiLink)
            apiRequest()
        case 2:
            apiLink = "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=2017-05-22&endDate=2017-05-22"
            apiRequest()
            
        default:
            apiLink = "http://planvine.com/api/v1.7/event/?apiKey=b23e175bae444126bde7026d60498c8b&startDate=2016-05-21&endDate=2016-05-21"

        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            apiRequest()
            }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("jsonCell") as! CustomCell
        var dict = arrRes[indexPath.row]
        cell.lblTitle?.text = dict["title"] as? String
        cell.lblSubTitle?.text = dict["venues"]?[0]?["address"] as? String
        
        //return image for cell, and format
        let urlString = self.arrRes[indexPath.row]["image"]?["lowResolution"]?!["url"] as! String
        let url = NSURL(string: urlString)!
        let data = NSData(contentsOfURL: url)!
        let image = UIImage(data: data)
        cell.imageCellView?.image = image
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
    
    //pass variables from selected row to whatsOnViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? WhatsOnViewController {
            if let indexPath = self.tblJSON?.indexPathForSelectedRow {
                var dictArrRes = arrRes[indexPath.row]
                
                let titleVar = dictArrRes["title"] as? String
                let dateVar = dictArrRes["venues"]?[0]?["performances"]?![0]?["startDate"] as? String
                let timeVar = dictArrRes["venues"]?[0]?["performances"]?![0]?["startTime"] as? String
                let addressVar = dictArrRes["venues"]?[0]?["address"] as? String
                let locationLatVar = dictArrRes["venues"]?[0]?["lat"] as? Double
                let locationLongVar = dictArrRes["venues"]?[0]?["lng"] as? Double
                let bookingLinkVar = dictArrRes["venues"]?[0]?["performances"]?![0]?["sourceUrl"] as? String
                
                //pass variables
                destination.titlePassed = titleVar
                destination.datePassed = dateVar
                destination.timePassed = timeVar
                destination.addressPassed = addressVar
                destination.locationLongPassed = locationLongVar
                destination.locationLatPassed = locationLatVar
                destination.bookingLinkPassed = bookingLinkVar
                
            }
        }
    }
    
    //covert date to string formatted
    func formatDate(date: NSDate)-> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = formatter.stringFromDate(date)
        return newDate
        
    }
    
    //perfrom API request to gather data
    func apiRequest()
    {
        Alamofire.request(.GET, apiLink).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



