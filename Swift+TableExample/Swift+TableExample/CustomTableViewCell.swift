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
    private static let kHeight : CGFloat = 44.0
    
    @IBOutlet var lbl_title : UILabel!
    @IBOutlet var lbl_subTitle : UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        lbl_title.sizeToFit()
        lbl_subTitle.sizeToFit()
    }
    
    func configureCell (title : String, subTitle : String?)
    {
        lbl_title.text = title
        
        // Este es un ejemplo de implementacion de unwrap
        // Como sabemos que el segundo parametro es un optional, puede venir nil
        // if let nombre = optional es la forma de hacer unwrap. Si hay valor, se guarda en la let nueva, sino va al else.
        if let subTitleText = subTitle
        {
            lbl_subTitle.text = subTitle
        }
        else
        {
            lbl_subTitle.text = "Unknown"
        }
        
    }
    
    class func reuseIdentifier () -> String
    {
        return "CustomCell"
    }
    
    class func preferredHeight () -> CGFloat
    {
        return kHeight
    }


}
