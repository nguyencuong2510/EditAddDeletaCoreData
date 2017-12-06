//
//  TableViewController.swift
//  EditAddDeletaCoreData
//
//  Created by nguyencuong on 12/6/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var array: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            array = try AppDelegate.context.fetch(Person.fetchRequest()) as! [Person]
        } catch {
            fatalError("\(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    @IBAction func AddName(_ sender: UIBarButtonItem) {
        alert(vc: self, title: "New Name", message: "input name")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row].name
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            AppDelegate.context.delete(array[indexPath.row])
            array.remove(at: indexPath.row)
            AppDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectRow = tableView.indexPathForSelectedRow{
            let viewController = segue.destination as? ViewController
            viewController?.person = array[selectRow.row]
        }
    }
    
    
    
    func alert(vc: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "enter name"
        }
        
        let alertAction = UIAlertAction(title: "Save", style: .default) { (result: UIAlertAction) in
            let inputName = alertController.textFields?.first?.text
            
            let person = Person(context: AppDelegate.context)
            person.name = inputName
            AppDelegate.saveContext()
            
            self.array.append(person)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
}





