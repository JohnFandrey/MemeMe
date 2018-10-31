//
//  SentMemeCollectionViewCell.swift
//  ImagePicker
//
//  Created by John Fandrey on 4/19/18.
//  Copyright © 2018 John Fandrey. All rights reserved.
//

import UIKit
import Foundation

class SentMemeCollectionViewCell: UICollectionViewCell {  // Creates a class for the cells of the SentMemeCollectionView.  
    @IBOutlet weak var memeImageView: UIImageView!      // Creates an outlet for the imageView.
    var cellMeme: ImagePickerViewController.Meme!       // Creates a variable for to store the appropirate 'Meme'.
    var topText: String!                                 // Creates a variable to store the topText of the 'Meme'.
    var bottomText: String!                              // Creates a variable to store the bottomText of the 'Meme'.
    var originalImage: UIImage!                          // Creates a variable to store the orginal image.
    var memedImage: UIImage!                             //  Creates a variable to store the memedImage.  
}
