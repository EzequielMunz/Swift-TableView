//
//  UIViewController+Navigation.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/21/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func displayNavigationTitle (title : String)
    {
        self.title = title
    }
    
    func displayLeftArrow ()
    {
        let backButton : UIBarButtonItem = UIBarButtonItem (title: "<==", style: UIBarButtonItemStyle.Plain, target: self, action: Selector ("goBack"))
        backButton.tintColor = UIColor.blackColor()
        navigationItem.setLeftBarButtonItem(backButton, animated: false)
    }
    
    func goBack ()
    {
        navigationController?.popViewControllerAnimated(true)
    }
}
