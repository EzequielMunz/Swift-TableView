//
//  TableViewController.swift
//  Swift+TableExample
//
//  Created by Ezequiel on 7/20/15.
//  Copyright (c) 2015 Ezequiel Munz, Fede Gonzalez. All rights reserved.
//

import UIKit
import WatchConnectivity

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExampleProtocol, WCSessionDelegate
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
        
        tbl_dataTable.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 0.9, alpha: 1)
        
        // Set up the connection with the Apple Watch
        if WCSession.isSupported()
        {
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    private func configureNavigationBar ()
    {
        displayNavigationTitle("SWIFT")
        navigationController?.navigationBar.barTintColor = UIColor.cyanColor()
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
    
    override func viewDidAppear(animated: Bool)
    {
        // Aca vamos a mandar el array al watch para actualizar la info en el mismo.
        // Este es un ejemplo de Exception Handling de Swift 2
        // Se usa un bloque do {} catch {}, donde en el do {} realizamos los llamados a metodos que pueden tirar excepciones
        // El catch {} se encarga del manejo de esa excepcion.
        // Se usa el modificador try en la linea donde se llama al metodo que puede tirar excepciones
        do
        {
            let dataDic : [String:AnyObject] = ["Data" : dataArray]
            print (WCSession.defaultSession().paired)
            try WCSession.defaultSession().updateApplicationContext(dataDic)
        }
        catch
        {
            // El UIAlertView esta deprecado para iOS 9, y es reemplazado por el UIAlertController.
            // Para que tenga la funcionalidad del UIAlertView, le seteamos el UIAlertControllerStyle.Alert
            // Usamos el metodo "presentViewController" para mostrarlo
            let alert : UIAlertController = UIAlertController (title: "Error", message: "Hubo un problema al enviar la informacion.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction : UIAlertAction = UIAlertAction (title: "Ok", style: UIAlertActionStyle.Cancel, handler:{(action) in
                print ("Presionaste Ok")
            })
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
        }
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
            let imageCell : ImageTableViewCell = tableView.dequeueReusableCellWithIdentifier(ImageTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! ImageTableViewCell
            cell = imageCell
            
        case .Two:
            let customCell : CustomTableViewCell = tableView.dequeueReusableCellWithIdentifier(CustomTableViewCell.reuseIdentifier(), forIndexPath: indexPath) as! CustomTableViewCell
            customCell.configureCell(dataArray[indexPath.row].title, subTitle: dataArray[indexPath.row].subTitle)
            cell = customCell
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        // Esto nos permite a quitar los separators en las celdas vacias
        // 3 pixeles es el grosor default de los separadores, colocamos el footer como ultimo separador
        return 3.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let storyboard : UIStoryboard = UIStoryboard (name: "Main", bundle: NSBundle.mainBundle())
        let viewController : DetailsViewController = storyboard.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        viewController.delegate = self
        viewController.data = dataArray[indexPath.row]
        
        //Ejemplo de block (closure) con weak self
        //Se puede utilizar el modificador unowned en el caso en que se sabe que self no va a ser nil,
        //en cuyo caso no hay que usar el ?
        //Se utiliza weak cuando existe la posibilidad de que sea nil
        
        UIView.animateWithDuration(0.75,
            animations: { [weak self] () -> () in
                
                        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
                        let view : UIView? = self?.navigationController?.view
                        if let auxView = view
                        {
                            UIView.setAnimationTransition(UIViewAnimationTransition.CurlDown, forView: auxView, cache: false)
                        }
                        self?.navigationController?.pushViewController(viewController, animated: false)
                
                        })
        
        
    }
    
    // MARK: ExampleProtocol Methods
    
    func changedSubtitle(newText: String, data : ModelClass)
    {
        // El metodo find() nos permite obtener el indice de un objeto dentro del arreglo, si no lo encuentra, retorna nil,
        // Por lo que debemos declararlo como optional
        let index : Int? = dataArray.indexOf(data)
        
        if let unwrappedIndex = index
        {
            data.subTitle = newText
            dataArray[unwrappedIndex] = data
        }
        tbl_dataTable.reloadData()
    }

}















