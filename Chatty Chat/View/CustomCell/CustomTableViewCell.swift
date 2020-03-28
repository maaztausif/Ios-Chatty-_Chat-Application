//
//  CustomTableViewCell.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 27/03/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AvatarImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
