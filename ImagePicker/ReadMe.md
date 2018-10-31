**MemeMe**

**Introduction**

MemeMe is an iOS app that allows users to create Memes using their device's camera or photos stored on their device.

**Running MemeMe**

MemeMe can be run by opening the ImagePicker.xcodeproj file and then building and running the app in Xcode.

**Using MemeMe**

_Creating a Meme_

Creating a meme is easy.  To create a meme the user needs to press the + button in the top right corner of the screen.  Once the button is pressed the user will see a screen with four buttons:
    1. a share buttons located in the top left corner;
    2. a cancel button located in the top right corner;
    3. a camera button located in the bottom left corner; and
    4. an album button located in the bottom right corner.

The screen also has two text boxes that read 'Top' and 'Bottom'.  

The user can edit the text boxes by tapping into them.  Once editing of a text box begins, all of the buttons are disabled except for the cancel button.  The user can end editing of a text box by pressing return.  Once editing ends, then buttons that were enabled are reenabled.  

The share button is disabled until the user has selected an image and has edited both text fields.  The user can select an image for the Meme by tapping the album button and selecting an image from the user's library or by tapping the camera button and taking a photo for the meme.  

Once the share button is enabled, the user can press the share button to bring up the activity view controller.  The activity view controller will show the user all the options for sharing the meme.  One of the options is 'Save Image'.  If the user taps 'Save Image' the meme will be saved in the users photo album.  Once the image has been saved, the activity view controller will be dismissed and the user will again see the meme that was just saved.  

If the user presses the cancel button, the user will be taken back to the collection view or the table view.  The user can toggle between the collection view or table view using the tab bar at the bottom of the screen.  These views simply display the memes created by the user in either a table view or a collection view.  If the user selects any of the images in either the table view or the collection view then the user will be taken to another view where the image meme is enlarged for viewing.  

If the user would like to add another meme the user simply needs to press the + button in the top right corner of the screen.  

**Conclusion**

Thanks for using MemeMe.  I hope you enjoy the app.
