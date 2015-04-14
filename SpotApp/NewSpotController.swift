//
//  NewSpotController.swift
//  TrainSpot
//
//  Created by Joost van den Brandt on 13/03/15.
//  Copyright (c) 2015 Joost van den Brandt. All rights reserved.
//

import UIKit
import CoreLocation

class NewSpotController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    //3107
    var imagePicker : UIImagePickerController!;
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    var geoLocationManager = GeoLocationManager()
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func pictureButtonClick(sender: UIButton) {
        self.takeAPicture()
    }
    
    @IBAction func saveButtonClick(sender: AnyObject) {
        if(imageView.image != nil && nameField.text != "" && descriptionField.text != ""){
            let spotName = nameField.text
            let spotDescription = descriptionField.text
            let imageString = UIImageJPEGRepresentation(imageView.image, 0.2)
            let newSpotUrl = "http://compuplex.nl:10033/api/spots"
            geoLocationManager.fetchWithCompletion { (location, error) -> () in
                if var geoLocation = location{
                    let newSpot = Spot(newName: spotName, newDescription: spotDescription, newLatitude: (geoLocation.coordinate.latitude as CLLocationDegrees?)!, newLongitude: (geoLocation.coordinate.longitude as CLLocationDegrees?)!, newImage: Image(newData: imageString.base64EncodedStringWithOptions(nil), newFileExtension: "image/jpeg"))
                    PostRequest.HTTPPostJSON(newSpotUrl, jsonObj: newSpot.toDictionary(), callback: { (data,error) -> Void in
                        if(error != nil){
                            println(error)
                            println("Errored data: \(data)")
                        }else{
                            let alertController = UIAlertController(title: "Verstuurd", message:"Spot succesvol verstuurd", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "Oke", style: .Default, handler: { (action: UIAlertAction!) in
                                self.navigationController?.popViewControllerAnimated(true)
                            }))
                            dispatch_async(dispatch_get_main_queue(),{
                                self.presentViewController(alertController, animated: true, completion: nil)
                            });
                        }
                    })
                }
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    func takeAPicture(){
        if(UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)){
            imagePicker = UIImagePickerController();
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.takePicture();
            presentViewController(imagePicker, animated: true, completion: nil)
        }else{
            println("No camera found");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: { () -> Void in
            //niks
        })
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
