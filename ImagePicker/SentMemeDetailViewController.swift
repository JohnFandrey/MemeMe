//
//  SentMemeDetailViewController.swift
//  ImagePicker
//
//  Created by John Fandrey on 4/22/18.
//  Copyright © 2018 John Fandrey. All rights reserved.
//

import Foundation
import UIKit

class SentMemeDetailViewController: UIViewController {  // Creates a class for the SentMemeDetaiViewController.
        // MARK: Properties
        
        var meme: ImagePickerViewController.Meme!       // Creates a variable to store the appropriate meme.
        
        // MARK: Outlets
        
        @IBOutlet weak var memeImageView: UIImageView!  // Creates an outlet for the memeImageView.
        
        // MARK: Life Cycle
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.memeImageView!.image = meme.memedImage  // Sets the image of the memeImageView to the memedImage.
            self.tabBarController?.tabBar.isHidden = true  // hide the tabBar.  
        }
    }

