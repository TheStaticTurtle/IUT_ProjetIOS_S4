//
//  AddEditTableViewController.swift
//  ProjetIOS
//
//  Created by user190907 on 3/11/21.
//

import CoreLocation
import UIKit
import MapKit

class AddEditTableViewController: UITableViewController,CLLocationManagerDelegate {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var noteTF: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    var note: NotesModel?
    var pin: MKPointAnnotation!
    
    let mananager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        if let note = self.note {
            titleTF.text = note.title
            noteTF.text = note.content
            render(CLLocation(latitude: note.localisation.latitude, longitude: note.localisation.longitude))
        } else {
            mananager.desiredAccuracy = kCLLocationAccuracyBest
            mananager.delegate = self
            mananager.requestWhenInUseAuthorization();
            mananager.startUpdatingLocation()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mananager.stopUpdatingLocation()
            render(location)
        }
    }
    
    @IBAction func userLocatePressed(_ sender: Any) {
            mananager.desiredAccuracy = kCLLocationAccuracyBest
            mananager.delegate = self
            mananager.requestWhenInUseAuthorization();
            mananager.startUpdatingLocation()
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        self.pin = MKPointAnnotation()
        self.pin.coordinate = coordinate
        mapView.addAnnotation(self.pin)
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "saveUnwind" {
            let title = titleTF.text ?? ""
            let content = noteTF.text ?? ""
            let dateFormatterFR = DateFormatter()
            dateFormatterFR.dateFormat = "dd/MM/yyyy";
           
            
            self.note = NotesModel(
                title: title,
                content: content,
                lastModificationDate: Date(),
                localisation: LocationModel(
                    latitude:self.pin.coordinate.latitude,
                    longitude:self.pin.coordinate.longitude
                )
            )
        }
    }
    

}
