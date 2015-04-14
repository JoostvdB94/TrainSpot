//
//  NewLocationViewController.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 14/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit
import MapKit

class NewLocationViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        let marker = MKPointAnnotation()
        marker.coordinate = self.mapView.userLocation.coordinate
        marker.title = "Uw locatie"
        self.mapView.addAnnotation(marker)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapNoTextField(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func onTapSaveButton(sender: UIBarButtonItem) {
        if(self.nameField.text != "" && self.latitudeField.text != "" && self.longitudeField.text != ""){
            var geoLocation = CLLocationCoordinate2D(latitude: (self.latitudeField.text as NSString).doubleValue, longitude: (self.longitudeField.text as NSString).doubleValue)
            var newLocation = Location(newId: "", newName: self.nameField.text, newType: "userLocation", newLatitude: geoLocation.latitude, newLongitude: geoLocation.longitude)
            PostRequest.HTTPPostJSON("http://compuplex.nl:10033/api/locations", jsonObj: newLocation.toDictionary()) { (data, error) -> Void in
                if error != nil {
                    println(error)
                }else{
                    let alertController = UIAlertController(title: "Verstuurd", message:"Locatie succesvol verstuurd", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Oke", style: .Default, handler: { (action: UIAlertAction!) in
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }))
                    dispatch_async(dispatch_get_main_queue(),{
                        self.presentViewController(alertController, animated: true, completion: nil)
                    });
                }
            }
        }
    }
    @IBAction func tapOnMap(sender: UITapGestureRecognizer) {
        var point: CGPoint = sender.locationInView(self.mapView)
        var tapLocation = self.mapView.convertPoint(point, toCoordinateFromView: self.mapView)
        self.mapView.removeAnnotations(mapView.annotations)
        let marker = MKPointAnnotation()
        marker.coordinate = tapLocation
        marker.title = self.nameField.text
        self.mapView.addAnnotation(marker)
        
        self.latitudeField.text = "\(tapLocation.latitude)"
        self.longitudeField.text = "\(tapLocation.longitude)"
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
