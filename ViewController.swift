//
//  ViewController.swift
//  Prayers
//
//  Created by Rabih Fawaz on 12/02/2017.
//  Copyright © 2017 Rabih Fawaz. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    let managedObjectContext = (UIApplication.shared.delegate
        as! AppDelegate).persistentContainer.viewContext
    
    var y:Int = 0
    @IBOutlet weak var myStatus: UILabel!
    
    override func viewDidLoad() {
        swInit()
        myDate.text =  CalcTodayDate(x: y)
        readData(selDate: myDate.text!)
//        var dataChanged = false
    }
    
    func swInit () {
        lblSobh.text = "0"
        lblDuhr.text = "0"
        lblAsr.text = "0"
        lblMaghrib.text = "0"
        lblIshaa.text = "0"
        swUpdate()
    }
    
    func swUpdate()
    {
        lblSobh.text == "1" ? (swSobh.isOn = true): (swSobh.isOn = false)
        lblDuhr.text == "1" ? (swDuhr.isOn = true): (swDuhr.isOn = false)
        lblAsr.text == "1" ? (swAsr.isOn = true): (swAsr.isOn = false)
        lblMaghrib.text == "1" ? (swMaghrib.isOn = true): (swMaghrib.isOn = false)
        lblIshaa.text == "1" ? (swIshaa.isOn = true): (swIshaa.isOn = false)
    }
    
    
    @IBAction func goToday(_ sender: Any)
    {
        y = 0
        myDate.text =  CalcTodayDate(x: y)
        readData(selDate: myDate.text!)

    }
    @IBAction func saveBtn(_ sender: Any)
    {
        readData(selDate: myDate.text!)
        if myStatus.text != "No Match"
        {
            print("myStatus:" , myStatus.text!)
            print(myDate.text!)
        } else{
        saveData()
        }
    }
    
    func readData(selDate:String)
    {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Prayers",
                                           in: managedObjectContext)
            let request: NSFetchRequest<Prayers> = Prayers.fetchRequest()
            request.entity = entityDescription
            let pred = NSPredicate(format: "(myDate = %@)", myDate.text!)
            request.predicate = pred
            do {
                var results = try managedObjectContext.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    myDate.text = match.value(forKey: "myDate") as? String
                    
                    lblSobh.text = match.value(forKey: "mySobh") as? String
                    lblDuhr.text = match.value(forKey: "myDuhr") as? String
                    lblAsr.text = match.value(forKey: "myAsr") as? String
                    lblMaghrib.text = match.value(forKey: "myMaghrib") as? String
                    lblIshaa.text = match.value(forKey: "myIshaa") as? String
                    swUpdate()
                    myStatus.text = "Matches found: \(results.count)"
                } else {
                    myStatus.text = "No Match"
//                    swInit()
                }
            } catch let error {
                myStatus.text = error.localizedDescription
            }
        }
    
    
    func saveData()
    {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Prayers", in: managedObjectContext)
        let prayers = Prayers(entity: entityDescription!, insertInto: managedObjectContext)
        
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Prayers")
        let predicate = NSPredicate (format: "myDate =  '\(myDate)'" )
        fetchRequest.predicate = predicate
        do
        {
            let test = try context?.fetch(fetchRequest)
            if test?.count == 1
            {
                let objectUpdate = test![0] as! NSManagedObject
                objectUpdate.setValue(lblSobh.text!, forKey:"mySobh")
                do{
                    try context?.save()
                }
                catch
                {
                    print(error)
                }
            }}
        catch{
            print(error)
        }
            }
            
    
        //    let empId = "001"
        //    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EmpDetails")
        //    let predicate = NSPredicate(format: "empId = '\(empId)'")
        //    fetchRequest.predicate = predicate
        //    do
        //    {
        //    let test = try context?.fetch(fetchRequest)
        //    if test?.count == 1
        //    {
        //    let objectUpdate = test![0] as! NSManagedObject
        //    objectUpdate.setValue("newName", forKey: "name")
        //    objectUpdate.setValue("newDepartment", forKey: "department")
        //    objectUpdate.setValue("001", forKey: "empID")
        //    do{
        //    try context?.save()
        //    }
        //    catch
        //    {
        //    print(error)
        //    }
        //    }
        //    }
        //    catch
        //    {
        //    print(error)
        //    }

        
//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "EEEE, MMMM dd, yyyy"
//        let strDate = dateformatter.date(from: myDate.text!)
//        print(strDate!)
//        [self.device setValue:self.nameTextField.text forKey:@"name"];
//        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        
        prayers.myDate = myDate.text
        prayers.mySobh = lblSobh.text!
        prayers.myDuhr = lblDuhr.text!
        prayers.myAsr = lblAsr.text!
        prayers.myMaghrib = lblMaghrib.text!
        prayers.myIshaa = lblIshaa.text!
        do {
            try managedObjectContext.save()
            myStatus.text = "Contact Saved"
        } catch let error {
            myStatus.text = error.localizedDescription
        }
        

        
    }
    
    @IBOutlet weak var myDate: UILabel!
    
    
    @IBOutlet weak var lblSobh: UILabel!
    @IBOutlet weak var lblDuhr: UILabel!
    @IBOutlet weak var lblAsr: UILabel!
    @IBOutlet weak var lblMaghrib: UILabel!
    @IBOutlet weak var lblIshaa: UILabel!
    
    
    @IBOutlet weak var swSobh: UISwitch!
    
    @IBOutlet weak var swDuhr: UISwitch!

    @IBOutlet weak var swAsr: UISwitch!
    
    @IBOutlet weak var swMaghrib: UISwitch!
    
    @IBOutlet weak var swIshaa: UISwitch!
    
    @IBOutlet weak var SobhRpt: UILabel!
    @IBOutlet weak var DuhrRpt: UILabel!
    @IBOutlet weak var AsrRpt: UILabel!
    @IBOutlet weak var MaghribRpt: UILabel!
    @IBOutlet weak var IshaaRpt: UILabel!
    
    
    @IBAction func swSobh(_ sender: Any){
        swSobh.isOn ? (lblSobh.text = "1") : (lblSobh.text = "0")
        saveData()
}

    @IBAction func swDuhr(_ sender: Any) {
        swDuhr.isOn  ? (lblDuhr.text = "1") : (lblDuhr.text = "0")
        saveData()
    }

    @IBAction func swAsr(_ sender: Any) {
        swAsr.isOn ? (lblAsr.text = "1") : (lblAsr.text = "0")
        saveData()
    }
    
    @IBAction func swMaghrib(_ sender: Any) {
        swMaghrib.isOn ? (lblMaghrib.text = "1") : (lblMaghrib.text = "0")
        saveData()
    }

    @IBAction func swIshaa(_ sender: Any) {
        swIshaa.isOn ? (lblIshaa.text = "1") : (lblIshaa.text = "0")
        saveData()
    }


    @IBAction func SwipeRight(_ sender: Any) {
        y = y + 1
        myDate.text = CalcTodayDate(x: y )
        readData(selDate: myDate.text!)
        if myStatus.text != "No Match"
        {
            print("myStatus:" , myStatus.text!)
            print(myDate.text!)
        } else{
            saveData()
        }

    }


    @IBAction func SwipeLeft(_ sender: Any) {
        y = y - 1
        myDate.text = CalcTodayDate(x: y)
        readData(selDate: myDate.text!)
        if myStatus.text != "No Match"
        {
            print("myStatus:" , myStatus.text!)
            print(myDate.text!)
        } else{
            saveData()
        }

    }



//    func write(toFile path: String, options writeOptionsMask: NSData.WritingOptions = []) throws {}
    
//    let empId = "001"
//    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EmpDetails")
//    let predicate = NSPredicate(format: "empId = '\(empId)'")
//    fetchRequest.predicate = predicate
//    do
//    {
//    let test = try context?.fetch(fetchRequest)
//    if test?.count == 1
//    {
//    let objectUpdate = test![0] as! NSManagedObject
//    objectUpdate.setValue("newName", forKey: "name")
//    objectUpdate.setValue("newDepartment", forKey: "department")
//    objectUpdate.setValue("001", forKey: "empID")
//    do{
//    try context?.save()
//    }
//    catch
//    {
//    print(error)
//    }
//    }
//    }
//    catch
//    {
//    print(error)
//    }
    

}
