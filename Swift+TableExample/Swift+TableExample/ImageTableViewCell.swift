//
//  ImageTableViewCell.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/21/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell
{
    @IBOutlet var img_view : UIImageView!
    
    // Las constantes se declaran como let
    // Si necesitamos usar un let/var en un metodo de clase, necesitamos el modificador static
    private static let kHeight : CGFloat = 200.0
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        img_view.image = UIImage(named: "Image")
    }
    
    // Los metodos estaticos se declaran con la palabra clave class
    class func reuseIdentifier () -> String
    {
        return "ImageCell"
    }
    
    class func preferredHeight () -> CGFloat
    {
        return kHeight
    }

}
