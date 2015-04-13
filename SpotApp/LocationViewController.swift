//
//  LocationViewController.swift
//  TrainSpot
//
//  Created by User on 12/04/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var locations = [Location]()
    var manager: GeoLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.addLocationsToList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return locations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("LocationCell") as! UITableViewCell
        cell.textLabel?.text=self.locations[indexPath.row].name as String
        cell.detailTextLabel?.text=String(format: "%.1f KM", self.locations[indexPath.row].distance)
        cell.updateConstraintsIfNeeded();
        return cell
    }
    
   
    func addLocationsToList(){
        let locationsUrl = "http://compuplex.nl:10033/api/locations"
        
        //
        // request the current location
        //
        manager = GeoLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let geoLocation = location {
                GetRequest.HTTPGetJSON(locationsUrl, callback: { (data, error) -> Void in
                    if error != nil {
                        println(error)
                    }else{
                        for (locationData) in data {
                            var tmpLocation = Location(newId: locationData["_id"] as! String, newName: locationData["name"] as! String, newType: locationData["type"] as! String,newLatitude: locationData["latitude"] as! Double, newLongitude: locationData["longitude"] as! Double)
                            tmpLocation.distance = geoLocation.distanceFromLocation(tmpLocation.getLocation()) / 1000
                            self.locations.append(tmpLocation)
                        }
                    }
                    self.locations.sort({$0.distance < $1.distance})
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView!.reloadData()
                    });
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                })
            } else if let err = error {
                println(err)
            }
            
            // destroy the object immediately to save memory
            self.manager = nil
        }

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
