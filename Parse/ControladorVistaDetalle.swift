//
//  ControladorVistaDetalle.swift
//  Parse
//
//  Created by Apple on 21/07/15.
//  Copyright (c) 2015 mcanche. All rights reserved.
//

import UIKit
import Parse

class ControladorVistaDetalle: UIViewController
{

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var nombrelocal: UITextField!
    @IBOutlet weak var capital: UITextField!
    @IBOutlet weak var moneda: UITextField!
    
    var currentObject : PFObject?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Unwrap the current object object
        if let object = currentObject
        {
            nombre.text = object["nombre"] as! String
            nombrelocal.text = object["nombrelocal"] as! String
            capital.text = object["capital"] as! String
            moneda.text = object["codigomoneda"] as! String
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func guardar(sender: AnyObject)
    {
        // Unwrap the current object object
        if let object = currentObject
        {
            object["nombre"] = nombre.text
            object["nombrelocal"] = nombrelocal.text
            object["capital"] = capital.text
            object["codigomoneda"] = moneda.text
            // Save the data back to the server in a background task
            object.saveEventually(nil)
        }
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
}
