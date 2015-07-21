//
//  CustomTableViewCell.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/20/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell
{

    @IBOutlet var lbl_title : UILabel!
    @IBOutlet var lbl_subTitle : UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        lbl_title.sizeToFit()
        lbl_subTitle.sizeToFit()
    }
    
    class func reuseIdentifier () -> String
    {
        return "CustomCell"
    }

}
