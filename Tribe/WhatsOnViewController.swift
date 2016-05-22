//
//  WhatsOnViewController
//  Tribe
//
import UIKit
import MapKit

class WhatsOnViewController: UIViewController {
    
    @IBOutlet weak var titleTestVar: UILabel!
    @IBOutlet weak var dateTestVar: UILabel!
    @IBOutlet weak var timeTestVar: UILabel!
    @IBOutlet weak var addressTestVar: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var titlePassed:String?
    var datePassed: String?
    var timePassed: String?
    var addressPassed: String?
    var locationLongPassed: Double?
    var locationLatPassed: Double?
    var bookingLinkPassed: String?
    
    //set radius (zoom)
    let regionRadius: CLLocationDistance = 1000
    
    //bookNow Button action to send user to gig safari page
    @IBAction func bookNow(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: bookingLinkPassed!)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //center map on venue location and annotate with pin + details
        let initialLocation = CLLocation(latitude: locationLatPassed!, longitude: locationLongPassed!)
        centerMapOnLocation(initialLocation)
        let coordinateLocation = CLLocationCoordinate2D(latitude: locationLatPassed!, longitude: locationLongPassed!)
        annotateMap(coordinateLocation)
        
        //pass data from table view to detail view
        titleTestVar.text = titlePassed
        addressTestVar.text = addressPassed
        //timeTestVar.text = timePassed
        dateTestVar.text = datePassed
    }
    
    //on load, center mapView on given coordinates
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //annotate map with pin and gig details
    func annotateMap(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = titlePassed
        annotation.subtitle = addressPassed
        mapView.addAnnotation(annotation)
        
    }
    //covert to date data type - date
    func formatDate(date: String)-> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = formatter.dateFromString(date) as NSDate!
        return newDate
        
    }
    //covert to date date type - time
    func formatTime(date: String)-> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let newDate = formatter.dateFromString(date) as NSDate!
        return newDate
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
