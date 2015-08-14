//
//  InterfaceController.swift
//  WatchOS 2 Example Extension
//
//  Created by Ezequiel on 8/12/15.
//  Copyright © 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate
{

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if WCSession.isSupported()
        {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    // Este metodo es el encargado de manejar el mensaje que se manda desde la aplicacion.
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject])
    {
        print ("Got It!")
    }
}
