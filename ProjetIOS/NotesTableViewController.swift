//
//  NotesTableViewController.swift
//  ProjetIOS
//
//  Created by user191414 on 3/4/21.
//

import UIKit

class NotesTableViewController: UITableViewController {
    let dateFormatterFR = DateFormatter();
    var notes: [NotesModel] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatterFR.dateFormat = "dd/mm/yyyy";
        
        notes = [
            NotesModel(title: "TestA", content: "azertyuiop", lastModificationDate: dateFormatterFR.date(from: "17/12/2001")!, localisation:  LocationModel(latitude:0, longitude:0)),
            NotesModel(title: "TestB", content: "qwertyuiop", lastModificationDate: dateFormatterFR.date(from: "04/03/2021")!, localisation:  LocationModel(latitude:0, longitude:0)),
            NotesModel(title: "TestC", content: "abcdefghij", lastModificationDate: dateFormatterFR.date(from: "25/02/2020")!, localisation:  LocationModel(latitude:0, longitude:0)),
        ]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    @IBAction func unwindFromAddEdit(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let x = notes[indexPath.row]
        cell.textLabel?.text = x.title
        cell.detailTextLabel?.text = dateFormatterFR.string(from: x.lastModificationDate)
        cell.showsReorderControl = true;
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moved_note = notes.remove(at: fromIndexPath.row)
        notes.insert(moved_note, at: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
