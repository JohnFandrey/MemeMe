//
//  SentMemesTableViewController.swift
//  ImagePicker
//
//  Created by John Fandrey on 4/19/18.
//  Copyright © 2018 John Fandrey. All rights reserved.
//

// Much of the code below is based on code used in the Udacity Bond Villains app.  The code was modified to be used in the MemeMe2.0 app.

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {                         // Create a class 'SentMemesTableViewController'.
    var memes: [ImagePickerViewController.Meme]! {  // Create an array of memes, specifcally an array of structs. The struct is the 'Meme' struct defined in the ImagePickerViewController.
        let object = UIApplication.shared.delegate    // Creates a constant 'object' and sets it equal to the UIApplication delegate.
        let appDelegate = object as! AppDelegate    //   Creates a constant 'appDelegate' and sets it equal to 'object'.
        return appDelegate.memes       // returns the array of memes defined in AppDelegate.Swift, effectively setting the array of
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count      // sets the number of rows to the number of items in the 'memes' array.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath) // create a constant 'cell' and set it equal to the value returned by the function 'tableView.dequeReusableCell(withIdentifier: "SentMemesTableViewCell", for: indexPath).
        let cellMeme = self.memes[indexPath.row]  // create a constant 'cellMeme' and set it equal to a meme in the memes array using the row number of the 'indexPath' to access the correct meme.
        cell.textLabel?.textAlignment = NSTextAlignment.center  // Set the alignment of the cell textLabel to center.
        cell.textLabel?.text = "\(cellMeme.topText)...\(cellMeme.bottomText)" // Sets the content of the 'cell' textLabel.
        cell.imageView?.image = cellMeme.memedImage  // Sets the image of the of the 'cell' imageView to the 'memedImage' of 'cellMeme'.
        return cell  // returns the cell.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false // reveal the navigationBar.
        self.tabBarController?.tabBar.isHidden = false  // reveal the tabBar.  
        tableView!.reloadData()  // reloads the tableView data.  This function is called to ensure that once a user navigates back to the tableView, the newly created meme is listed in the table.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  // This function calls the SentMemeDetailViewController and displays the meme that is represented by the selected row.
        // The safe unwrapping of the storyboard and detailController was suggested by a reviewer at Udacity.
        if let storyboard = self.storyboard, let detailController = storyboard.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as? SentMemeDetailViewController {
            detailController.meme = self.memes[(indexPath as NSIndexPath).row]  // sets the 'meme' of the 'SentMemeDetailViewController' to the meme of the appropriate row in the tableView.
            self.navigationController!.pushViewController(detailController, animated: true) // pushes the detailViewController onto the stack.
        } else {
            displayError("There was an issue display the image you selected.  Please try again.")
        }
    }
        
    func displayError(_ error: String){
        // Code for displaying an alert notification was obtained at https://www.ioscreator.com/tutorials/display-alert-ios-tutorial-ios10.  The tutorial for displaying this type of alert was posted by Arthur Knopper on January 10, 2017.
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
        
}
