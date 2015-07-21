//
//  ModelClass.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/20/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import Foundation

class ModelClass : NSObject
{
    // En swift, las variables declaradas normalmente tienen la particularidad de que no pueden ser nil.
    // Si se sabe que una variable puede llegar a ser nil, se tiene que usar lo que se llama Optional(<T>), que se puede abreviar como <T>?
    // Hay 2 tipos de optionals:
    //      ?: La variable puede ser nil y es necesario unwrappear cada vez que se quiera utilizar el valor contenido
    //      !: La variable puede ser nil, pero yo me aseguro que cuando tenga que usarla, va a tener un valor y por esto no es necesario unwrappear
    // Las variables que no son declaradas como optionals, tienen que ser inicialisadas con un valor != nil en los constructores definidos
    
    var title : String
    var subTitle : String?
    
    init (titleString : String, subTitleString : String?)
    {
        title = titleString
        subTitle = subTitleString
        
        super.init()
    }
}