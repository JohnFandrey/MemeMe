//
//  SentMemesCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by John Fandrey on 4/19/18.
//  Copyright © 2018 John Fandrey. All rights reserved.
//

// The code below was written based on the examples from the Udacity Bond Villains app.  The code provided by Udacity was rewritten to function in the MemeMe2.0 app.  

import Foundation
import UIKit


class SentMemesCollectionViewController: UICollectionViewController {  // Creates a class for the SentMemesCollectionViewController.
   
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!         // Creates an outlet for the flowLayout for the UICollectionView.
    
        var memes: [ImagePickerViewController.Meme]! {     // Creates an array of 'Memes' from the ImagePickerViewController 'Meme' struct.
        let object = UIApplication.shared.delegate     // Creates a constant 'object' and sets it equal to the UIApplication delegate.
        let appDelegate = object as! AppDelegate       // Creates a constant 'appDelegate' and sets it equal to 'object'.
        return appDelegate.memes  // Returns an array of 'Memes' effectively setting the 'memes' variable to the array of Meme's in the AppDelegate.
        }
    
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return memes.count // Sets the number of items in the CollectionView to the number of items in the array.
        }
    
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell  // Creates a constant 'cell', uses the SentMemeCollectionViewCell class.
            let meme = self.memes[(indexPath as NSIndexPath).row]  // Creates a constant 'meme' and sets it equal to the item in the 'Memes' array at the index specified.
            cell.memeImageView.image = meme.memedImage             // Sets the image to the 'memedImage' of the Meme.
            return cell                                            // returns the cell.
        }
    
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
            let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController // Creates a constant 'detailController' and sets it equal to 'SentMemeDetailViewController".
            detailController.meme = self.memes[(indexPath as NSIndexPath).row]  // Sets the "meme" to the correct meme using the Memes array and setting the indexPath as the index.
            self.navigationController!.pushViewController(detailController, animated: true) // Pushes the SentMemeDetailViewController onto the stack.
        }
    
        override func viewDidLoad() {
            let space: CGFloat = 3.0                                            // Sets a constant "space" of type CGFloat to 3.0.
            let widthDimension = (view.frame.size.width - (2 * space)) / 3.0  // Sets a constant 'widthDimension'
            let heightDimension = (view.frame.size.height - (2 * space)) / 3.0  // Sets a constant 'heightDimension'
            flowLayout.minimumInteritemSpacing = space                          // Sets the minimumInteritemSpacing = space.
            flowLayout.minimumLineSpacing = space                               // Sets the minimumLineSpace = space.
            flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)  // Sets the itemSize.
        }
    
        override func viewWillAppear(_ animated: Bool) {
            collectionView!.reloadData()  // Reloads the data so that the collectionView displays newly created memes.
            self.navigationController?.isNavigationBarHidden = false  // reveals the navigationBar.
            self.tabBarController?.tabBar.isHidden = false  // reveals the tabBar.  
        }
}
