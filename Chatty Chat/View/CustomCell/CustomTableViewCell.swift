//
//  CustomTableViewCell.swift
//  Chatty Chat
//
//  Created by Maaz Bin Tausif on 01/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var AvatarImageView: UIImageView!
    @IBOutlet weak var MessageBackground: UIView!
    @IBOutlet weak var SenderUserName: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
