//
//  SentMemeTableViewCell.swift
//  ImagePicker
//
//  Created by Katie Fandrey on 4/22/18.
//  Copyright © 2018 Katie Fandrey. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    @IBOutlet weak var topTextLabel: UILabel!
    var cellMeme: ImagePickerViewController.Meme!
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
}
