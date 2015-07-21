//
//  DetailsViewController.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/21/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    var data : ModelClass!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
    }
    
    private func configureNavigationBar ()
    {
        title = data.title
    }

}
