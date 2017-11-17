//
//  ViewController.swift
//  iosFinal-Chuck
//
//  Created by Chucks Mac Book on 11/17/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit
import CoreData


class ContactViewController: UITableViewController{
    var contactList = [Contact]()
    let objDatabase = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                loadData()
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is IndexPath {
            // if this type is an SNIndexPath then it is an EDIT
            // we need to findout the NSINdexPath that was sent here from the performsegue.
            // then create and cast the controller that we will go to from the segue.destination.
            // then, with the instance of the addviewcontroller, get the delegate so that
            // we can use the functions and data from the newly created controller.
            if segue.identifier == "editSegue"{
                print(sender!, "THIS IS TEH ESENDER")
                let indexPath = sender as! NSIndexPath
                let addVC =  segue.destination as! UINavigationController
                let editVC = addVC.topViewController as! EditViewController
                editVC.addDelegate = self
                //from this controller get the delegate and set it up as the instance of teh THIS view controller.
                editVC.firstText = contactList[indexPath.row].first!
                editVC.lastText = contactList[indexPath.row].last!
                editVC.phoneText = (contactList[indexPath.row].phoneNumber)!
                editVC.indexPath = indexPath
                
                // you need to do this for sure.....this will set up the delegate
                // without this, this controller will not know where to get the data from.
            } else if segue.identifier == "viewSegue"{
                print(sender!, "THIS IS TEH FOR TEH VEIW VIEW")
                let indexPath = sender as! NSIndexPath
                let editVC = segue.destination as! ViewViewController
                editVC.firstText = contactList[indexPath.row].first!
                editVC.lastText = contactList[indexPath.row].last!
                editVC.phoneText = (contactList[indexPath.row].phoneNumber)!
            }
            
            
            
        } else {
            // this is the new ADD...
            let addVC =  segue.destination as! UINavigationController
            let editVC = addVC.topViewController as! EditViewController
            editVC.addDelegate = self
            
        }
    }
    func loadData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let result = try objDatabase.fetch(request)
            contactList = result as! [Contact]
        } catch {
            print("\(error)")
        }
        //tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactViewController: ContactDelegate {
    func addContact(by controller: Any?, firstName first: String?, lastName last: String?, phoneNumber phone: String, indexPath indexpath: NSIndexPath?) {
        if indexpath != nil {
            
            // this is going to be an edit
            // this is an edit..!.so update the array at the index location
            contactList[indexpath!.row].first = first
            contactList[indexpath!.row].last = last
            contactList[indexpath!.row].phoneNumber = phone
        } else {
            // this is going to be an add
            let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: objDatabase) as! Contact
            newContact.first = first
            newContact.last = last
            newContact.phoneNumber = phone
            contactList.append(newContact)
            print(contactList, "THIS IS THE CONTACT LIST")
        }
        
        do {
            try objDatabase.save()
            print(contactList, "THIS IS ")
        } catch {
            print("error \(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

extension ContactViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCells", for: indexPath)
        cell.textLabel?.text = contactList[indexPath.row].first! + " " + contactList[indexPath.row].last!
        
//        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
         cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        print(contactList[indexPath.row].phoneNumber!, "        THIS SI TEH PHNE")
        return cell
    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        contactList.remove(at: indexPath.row)
//        do {
//            try objDatabase.save()
//            print("Error-------THE DELEETE---")
//        } catch {
//            print(error, "Error----------")
//        }
//        tableView.reloadData()
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "editSegue", sender: indexPath)
        let alert = UIAlertController(title: "Action", message: "Contacts",
                                      preferredStyle: .alert)
//        let newRowIndex = self.author.books?.count
        let editAction = UIAlertAction(title: "Edit", style: .default){
             UIAlertAction -> Void in
            self.performSegue(withIdentifier: "editSegue", sender: indexPath)
            }
        let viewAction = UIAlertAction(title: "View", style: .default){
            UIAlertAction -> Void in
            self.performSegue(withIdentifier: "viewSegue", sender: indexPath)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default){
            UIAlertAction -> Void in
            
            print("were'er deleteing")
            let removeContact = self.contactList[indexPath.row] as Contact
            self.contactList.remove(at: indexPath.row)
            self.objDatabase.delete(removeContact)
            do {
                try self.objDatabase.save()
                print("Error-------THE DELEETE---")
            } catch {
                print(error, "Error----------")
            }
            tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            UIAlertAction -> Void in
        }
//        alert.addTextField {
//            UITextField -> Void in
//        }
        
        alert.addAction(viewAction)
        alert.addAction(editAction)
         alert.addAction(deleteAction)
        alert.addAction(cancelAction)
       
        present(alert, animated: true, completion: nil)
    }

}

