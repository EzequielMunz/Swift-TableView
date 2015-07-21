//
//  TableViewController.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/20/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // Los enums pueden extender de Int para tener un valor entero de referencia
    // Cada componente dentro del enum se define con la palabra clave "case"
    private enum SectionTag : Int
    {
        case One = 0
        case Two
        case TotalCount
    }
    
    // Los IBOutlets son implicity unwrapped optionals (!) por defecto
    @IBOutlet var tbl_dataTable : UITableView!
    
    // En swift, toda property y/o metodo que no tenga el modificador private, sera publico.
    // Los arrays en swift se declaran de la forma [TipoDeDato], es decir, el tipo de dato contenido en el array entre corchetes.
    private var dataArray : [ModelClass] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // La forma de llamar un metodo en swift es pasando los parametros entre ()
        // Si los metodos estan definidos en la misma clase, se pueden llamar directamente sin necesidad de usar el self.
        configureNavigationBar()
        initData()
        
    }
    
    private func configureNavigationBar ()
    {
        title = "Table Example"
    }
    
    private func initData ()
    {
        // Cuando llamamos un metodo de un objeto de otra clase, se llama de la forma objeto.metodo (param1, param2)
        // Para agregar data a un array, se usa el metodo append(<T>) del array de Swift
        // En swift, se reemplaza el alloc/init, con la notacion clasica Clase (params)
        
        dataArray.append(ModelClass(titleString: "Ezequiel", subTitleString: "MDP Office"))
        dataArray.append(ModelClass(titleString: "Federico", subTitleString: "MDP Office"))
        dataArray.append(ModelClass(titleString: "Nico", subTitleString: "MDP Office"))
        dataArray.append(ModelClass(titleString: "Gabo", subTitleString: nil))
        dataArray.append(ModelClass(titleString: "Lucas", subTitleString: "MDP Office"))
    }
    
    
    // MARK: - TableView Data Source & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // El TotalCount del enum lo creamos para obtener la cantidad de casos dinamicamente
        return SectionTag.TotalCount.rawValue
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Para usar un switch combinado con un enum, hay que inicializar una var del enum con el rawValue que corresponda.
        // Si el enum extiende de Int, el rawValue va a ser un valor entero.
        // Es necesario unwrappear el resultado por si el Int que se pasa por parametro no puede inicializar in case del enum.
        // El resultado sera un componente del enum, ej. SectionTag.One, el cual se puede abreviar en el case como .One

        switch SectionTag (rawValue: section)!
        {
        case .One:
            return 1
            
        case .Two:
            return dataArray.count
            
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        switch SectionTag (rawValue: indexPath.section)!
        {
        case .One:
            return ImageTableViewCell.preferredHeight()
            
        case .Two:
            return CustomTableViewCell.preferredHeight()
            
        default:
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell!
        
        switch SectionTag (rawValue: indexPath.section)!
        {
        case .One:
            // Si declaramos una variable como no optional, y queremos hacer un downcast a una clase especifica, es necesario unwrappear en el as, de la forma as!
            // Si esa variable la declaramos como optional, hacemos el downcast con as?. Esto nos dice que si no puede castear a la clase deseada, sera nil
            var imageCell : ImageTableViewCell = tableView.dequeueReusableCellWithIdentifier(ImageTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! ImageTableViewCell
            cell = imageCell
            
        case .Two:
            var customCell : CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier(CustomTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! CustomTableViewCell
            customCell.configureCell(dataArray[indexPath.row].title, subTitle: dataArray[indexPath.row].subTitle)
            cell = customCell
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }

}
