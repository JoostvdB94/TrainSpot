//
//  SpotsViewController.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 27/03/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit

class SpotsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource{
    var spotList = [Spot]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            GetRequest.HTTPGetJSON("http://trainspot.herokuapp.com/api/spots", callback: {(data : [[String:AnyObject]], error: String?) -> Void in
                
                if error != nil {
                    println(error)
                }else{
                    for (spotData) in data {
                        let imageArray = spotData["image"] as! [NSString:NSString]
                        let tmpImage = Image(newData: imageArray["data"]!, newFileExtension: imageArray["extension"]!)
                        var tmpSpot = Spot(newName: spotData["name"] as! NSString, newDescription: spotData["description"] as! NSString, newLatitude: spotData["latitude"] as! Double, newLongitude: spotData["longitude"] as! Double, newImage: tmpImage)
                        self.spotList.append(tmpSpot);
                    }
                }
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView!.reloadData()
                });
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            });
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SpotCell");
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
        return spotList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("SpotCell") as! UITableViewCell
        cell.textLabel?.text=spotList[indexPath.row].name as String;
        cell.detailTextLabel?.text = spotList[indexPath.row].description as String;
        cell.updateConstraintsIfNeeded();
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
