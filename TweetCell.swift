//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Brian Mendez on 10/9/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userTweetsLabel: UILabel!
    @IBOutlet weak var twitterProfilePic: UIImageView!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}