//
//  ViewController.swift
//  ImagePicker
//
//  Created by John Fandrey on 3/29/18.
//  Copyright © 2018 John Fandrey. All rights reserved.
//
// The code below has been modified for MemeMe2.0.  However, much of the code was previously included in my submission for the Udacity MemeMe1.0 project.
// The review for that submission can be found at https://review.udacity.com/#!/reviews/1139772.  

import Foundation
import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var bottomToolBar: UIToolbar!            // Creates outlet for the toolbar.
    @IBOutlet weak var topToolBar: UIToolbar!               // Creates an outlet for the topToolBar
    @IBOutlet weak var shareButton: UIBarButtonItem!        // Creates outlet for the shareButton.
    @IBOutlet weak var topTextField: UITextField!           // Creates an outlet for the topTextField.
    @IBOutlet weak var bottomTextField: UITextField!        // Creates an outlet for the bottomTextField.
    @IBOutlet weak var selectImage: UIBarButtonItem!        // Creates an outlet for the select imageButton.
    @IBOutlet weak var cameraButton: UIBarButtonItem!       // Creates an outlet for the camera button.
    @IBOutlet weak var imageDisplay: UIImageView!           // Creates an outlet for the UIImageView.
    @IBOutlet weak var cancelMeme: UIBarButtonItem!         // Creates an outlet for the cancel button.
    
    let textFieldDelegate = self                            // Set the ViewController as the UITextFieldDelegate.
    
    struct Meme{                                            // Create a struct with a topText, bottomText, originalImage, and memedImage property.
        var topText = ""                                    // topText will hold the text placed in the topTextField.
        var bottomText = ""                                 // bottomText will hold the text placed in the bottomTextField.
        var originalImage = UIImage()                       // originalImage will hold the original picture or image.
        var memedImage = UIImage()                          // memedImage will hold the original image with the text in the top and bottom text fields added.
    }
    
    let memeTextAttributes:[String: Any] = [                                            // Create a dictionary of text attributes.
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,                      // Set the color of the text outline to black.
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,                  // Set the color of the interior of the text to white.
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        // Set the font of the text to Helvetica with size 40.
        NSAttributedStringKey.strokeWidth.rawValue: -2.0
            // Set the strokewidth so that the outline and interior of the text are different colors.
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMemeMe()       // Call the configureMemeMe() function.  This function sets up meme.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)  // Enable or disable the camera button depending on presence of camera.
        subscribeToKeyboardNotifications() // Subscribe to Keyboard notifications so other functions can be called when the keyboard is displayed or hidden.
        hideNavigationBar(Hide: true)
        hideTabBar(Hide: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()     // Unsubscribe from keyboard notifications when view will disappear.
    }

    @IBAction func selectImage(_ sender: Any) {    // Creates an action for the select an image button.
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    @IBAction func takePhoto(_ sender: Any) {     // Creates an action for the takePhoto button.
      presentImagePickerWith(sourceType: .camera)
        }
    
    @IBAction func shareMeme(_ sender: Any) {               // Creates an action for the shareButton.
        /* I found an implementation of the below code for setting up the ActivityViewController on StackOverflow.com in a post by Suragch dated March 11, 2016.  The url for this post is https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift.  I have adapted the code to this project and added my own comments.  Where the comments are from Suragch I have provided attribution.
         */
        hideOrRevealToolbar(hide: true)
        let myMeme: UIImage = generateMemedImage()          // create a variable that calls the generateMemedImage() function.
        let imageToShare = [myMeme]                         // creates a variable that stores myMeme as type Any.
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)  // creates an instance of activity viewController.
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash - this comment included by Suragch on StackOverflow. See comment above for the URL to the post.
        self.present(activityViewController, animated: true, completion: nil) // present the view controller - this comment included by Suragch on StackOverflow.
        
        // I found the code for the line below on StackOverflow in a post by Joel Marquez dated January 13, 2018 at https://stackoverflow.com/questions/27454467/uiactivityviewcontroller-uiactivityviewcontrollercompletionwithitemshandler.
        activityViewController.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                self.save()
            }
        }
    }
    
    @IBAction func cancelMeme(_ sender: Any) {        // function that is called when cancel button is pressed.
        returnToPreviousScreen()                             // Calls a function that resets the app.
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self       // Set the source to the photo library or camera depending on sourceType provided by function call.
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {   // Creates a function dealing with a canceled image selection.
    dismiss(animated: true, completion: nil)
    }
    
    // The imagePickerController function below allows a user to pick an image.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        shareButton.isEnabled = false                          // Disables the shareButton while the user is selecting an image.
        let myImage = UIImagePickerControllerOriginalImage     // Creates a variable myImage.
        if let image = info[myImage] as? UIImage {             // conditinally unwraps image.
            imageDisplay.image = image                         // Sets the image to display.
        dismiss(animated: true, completion: nil)               // dismisses the imagePicker. imagePickerController.
           shareButtonEnabled()
        }
    }
    
    func subscribeToKeyboardNotifications() {
        // The first line of code below calls the keyboardWillShow function when the software keyboard will be displayed.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        // The line above calls the keyboardWillHide function when the software keyboard will be hidden.
    }
    
    func unsubscribeFromKeyboardNotifications() {      // This function unsubscribes the viewController from keyboard notifications.
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {        // This function moves the view up so that the keyboard does not cover the textField.
        if bottomTextField.isEditing {                                // This line of code ensures that the view is moved only when the bottom textField is being edited.
        view.frame.origin.y = -getKeyboardHeight(notification)        // The line beginning 'view.frame.origin.y' moves the view upward.
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {       // This function moves the view to its original position once the keyboard is hidden.
        if bottomTextField.resignFirstResponder() == true {    // This line ensures that the view is changed only if the bottomTextField has resigned as the first responder.
        view.frame.origin.y = 0                               // This line resets the origin to 0.
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {        // This function returns the height of the software keyboard.
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func generateMemedImage() -> UIImage {                                     // This function generates an image consisting of the text in the top and bottom textfields and the image selected by the user.
                                // Hide the toolbar
        UIGraphicsBeginImageContext(self.view.frame.size)                      // The next few lines generate the memeImage.
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideOrRevealToolbar(hide: false)
        return memedImage                                                       // Returns the memeImage.
    }
    
    func hideOrRevealToolbar(hide: Bool){                          // Hides or reveals the toolbars.
        self.topToolBar.isHidden = hide
        self.bottomToolBar.isHidden = hide
    }
    
    func hideNavigationBar(Hide: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: false) // hide navigationBar.
    }
    
    func hideTabBar(Hide: Bool){
        self.tabBarController?.tabBar.isHidden = true // hide tabBar.  
    }
    
    func save() {                   // Saves the generated Meme, originalImage, and text.
        hideOrRevealToolbar(hide: true)
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageDisplay.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        hideOrRevealToolbar(hide: false)  // reveal the toolbar.
    }
    
    var topCount = 0        // Sets a count to be used in determining how many times the topTextField has been accessed.
    var bottomCount = 0     // Sets a count to be used in determining how many times the bottomTextField has been accessed.
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectImage.isEnabled = false                                           // Disables the selectImage, cameraButton, and sharebutton so that
        cameraButton.isEnabled = false                                          // the user has to press return in the textField being edited.
        shareButton.isEnabled = false
       textFieldEnabled(textField)
        if textField.tag == 0 && topCount == 0 {                  // Removes the text in the text field if the textField has not been edited.
            textField.text = ""
            topCount += 1
        }
        if textField.tag == 1 && bottomCount == 0 {               // Removes the text in the text field if the textField has not been edited.
            textField.text = ""
            bottomCount += 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {              // This function causes the keyboard to be hidden once the user presses return.
        textField.resignFirstResponder()                                        // The textfield resigns the first responder.
        textFieldEnabled(textField)                                             // The textFieldEnabled function is called to enable the inactive textField.
        shareButtonEnabled()                                                    // The shareButtonEnabled function is called to determine whether or not the share button should be enabled.
        selectImage.isEnabled = true                                            // The select image button is enabled once a user has pressed return.
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)         // Enables or disables the camera button depending on whether a camera is present.  
        return true
    }
    
    func shareButtonEnabled(){                                                 // When called this function checks to ensure that both textFields have been edited before the shareButton is enabled.
        if topCount != 0 && bottomCount != 0 && imageDisplay.image != nil {                 // Before the shareButton is enabled the topTextField, bottomTextField, and image must have been editted.
            shareButton.isEnabled = true                            // Enables the sharebutton.
        }
    }
    
    func textFieldEnabled(_ textField: UITextField){                // This function enables textFields and is called by the textFieldShouldReturn function.
                                                                    // This was done to prevent the user from selecting one textField while editing another.
        if textField.tag == 0 {                                     // The topTextField has a tag = 0.
            bottomTextField.isEnabled = true                        // The bottomTextField is enabled.
            if textField.text == "" {
                textField.text = "TOP"                              // The textField is impossible to see if blank.  This
            }                                                       // allows the user to see the field and edit it later if they press return while the textField is blank.
        }
        if textField.tag == 1 {                                     // The bottomTextField has a tag = 1.
            topTextField.isEnabled = true                           // The topTextField is enabled
            if textField.text == "" {
                textField.text = "BOTTOM"                           // The textField is impossible to see if blank.
            }                                                       // This enables the user to see the textField and edit it later if they press return while the textField is blank.
        }
    }

    func configureMemeMe(){                                                     // Sets up the imagePickerViewController.
        shareButton.isEnabled = false                                           // Disable the share button.
        topCount = 0                                                            // Sets the topCount.
        bottomCount = 0                                                         // Sets the bottomCount.
        imageDisplay.image = nil                                                // Resets the image display.
        configureTextFields(textField: topTextField, withText: "TOP")           // Configures the topTextField and sets the text to "TOP".
        configureTextFields(textField: bottomTextField, withText: "BOTTOM")     // Configures the bottomTextField and sets the text to "BOTTOM".
        hideOrRevealToolbar(hide: false)
    }
    
    func configureTextFields(textField: UITextField, withText: String){
        textField.delegate = self                                           // Set the delegate of the textField to self.
        textField.textAlignment = .center                                   // Align the text of the textField to the center.
        textField.defaultTextAttributes = memeTextAttributes                // Set the default text attributes to settings of memeTextAttributes.
        textField.text = withText                                           // Sets the text of the textField.
        textField.adjustsFontSizeToFitWidth = true                          // Shrinks the text to fit it within the textField.  
    }
    
    func returnToPreviousScreen(){
        self.navigationController!.popViewController(animated: true) //pops the current viewController off the stack so that the previous screen is displayed.
    }
}
