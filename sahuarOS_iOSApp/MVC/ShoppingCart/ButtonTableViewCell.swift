//
//  ButtonTableViewCell.swift
//  sahuarOS_iOSApp
//
//  Created by Felipe Montoya on 3/16/19.
//  Copyright © 2019 Felipe Montoya. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var confirmButton: UIButton!{
        didSet{
            confirmButton.layer.cornerRadius = 5.0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
