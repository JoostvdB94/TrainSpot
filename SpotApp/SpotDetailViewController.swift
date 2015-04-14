//
//  SpotDetailViewController.swift
//  TrainSpot
//
//  Created by User on 13/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SpotDetailViewController: UIViewController {

    @IBOutlet weak var spotTitleLabel: UILabel!
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var spotDescriptionLabel: UILabel!
    
    var spot = Spot(newName: "", newDescription: "", newLatitude: 0, newLongitude: 0, newImage: Image(newData: "",newFileExtension: ""))
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        super.loadView()
        spotTitleLabel.text = spot.name as String
        spotDescriptionLabel.text = spot._description as String
        let decodedData = NSData(base64EncodedString: spot.image.data as String, options: NSDataBase64DecodingOptions(rawValue: 0))
        var decodedimage = UIImage(data: decodedData!)
        spotImageView.image = decodedimage
        spotImageView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLocationButtonClick(sender: UIBarButtonItem) {
        var latitute:CLLocationDegrees =  self.spot.latitude
        var longitute:CLLocationDegrees =  self.spot.longitude
        
        let regionDistance:CLLocationDistance = 10000
        var coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        var options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        var placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.spot.name)"
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
