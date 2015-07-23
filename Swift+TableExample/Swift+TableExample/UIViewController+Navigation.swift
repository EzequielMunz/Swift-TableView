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
        // El navigation controller es una propiedad optional dentro de un ViewController.
        // Usando navigationController? nos aseguramos de que el metodo se llame solo si el navigation controller existe.
        // Usar "?" detras de un optional, es preguntar si es distinto de nil.
        navigationController?.popViewControllerAnimated(true)
    }
}
