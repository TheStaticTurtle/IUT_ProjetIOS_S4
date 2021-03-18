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
        
        dateFormatterFR.dateFormat = "dd/MM/yyyy HH:mm:ss";
        
        notes = [
            NotesModel(title: "TestA", content: "azertyuiop", lastModificationDate: dateFormatterFR.date(from: "17/12/2001 15:05:00")!, localisation:  LocationModel(latitude:0, longitude:0)),
            NotesModel(title: "TestB", content: "qwertyuiop", lastModificationDate: dateFormatterFR.date(from: "04/03/2021 23:37:56")!, localisation:  LocationModel(latitude:0, longitude:0)),
            NotesModel(title: "TestC", content: "abcdefghij", lastModificationDate: dateFormatterFR.date(from: "25/02/2020 08:00:00")!, localisation:  LocationModel(latitude:0, longitude:0)),
        ]
        
        let userDefaults = UserDefaults.standard
        if let savedNotes = userDefaults.object(forKey: "notes") as? Data {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([NotesModel].self, from: savedNotes) {
                notes = loadedNotes
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    func save_to_storage() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(encoded, forKey: "notes")
        }
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
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let x = notes[indexPath.row]
        cell.textLabel?.text = x.title
        cell.detailTextLabel?.text = dateFormatterFR.string(from: x.lastModificationDate)
        cell.showsReorderControl = true;
        
        return cell
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "saveUnwind" {
            let sourceVC = segue.source as! AddEditTableViewController
            
            if let note = sourceVC.note {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    // Modification d'un emoji
                    self.notes[selectedIndexPath.row] = note
                    tableView.reloadData()
                    save_to_storage()
                } else {
                    // Création d'un emoji
                    self.notes.append(note)
                    tableView.reloadData()
                    save_to_storage()
                }
            }

        }
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
        save_to_storage()
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moved_note = notes.remove(at: fromIndexPath.row)
        notes.insert(moved_note, at: to.row)
        tableView.reloadData()
        save_to_storage()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }*/
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue" {
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditVC = navController.topViewController as! AddEditTableViewController
            addEditVC.note = note
        }
    }
    

}
