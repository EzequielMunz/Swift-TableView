//
//  DetailsViewController.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/21/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit

protocol ExampleProtocol
{
    func changedSubtitle (newText : String, data : ModelClass)
}

class DetailsViewController: UIViewController
{
    var data : ModelClass!
    
    // La variable de tipo protocol deberia ser siempre optional
    var delegate : ExampleProtocol?
    
    @IBOutlet var lbl_description : UILabel!
    @IBOutlet var btn_apply : UIButton!
    @IBOutlet var txf_inputText : UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
        configureView()
    }
    
    private func configureView ()
    {
        lbl_description.text = "Ingrese el nuevo dato"
        btn_apply.layer.cornerRadius = 2
        btn_apply.layer.borderWidth = 2
        btn_apply.titleLabel?.text = "Apply"
    }
    
    private func configureNavigationBar ()
    {
        displayNavigationTitle (data.title)
        displayLeftArrow ()
    }
    
    // MARK: - Helper methods
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        resignFirstResponder()
    }
    
    @IBAction func buttonApplyPressed (sender : AnyObject!)
    {
        // Agregar "?" al final de delegate, nos sirve para preguntar si el delegate es distinto de nil
        delegate?.changedSubtitle(txf_inputText.text, data: data)
        navigationController?.popViewControllerAnimated(true)
    }

}
