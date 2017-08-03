//
//  TableViewController.swift
//  LockE Controller
//
//  Created by Alexander Li on 6/27/17.
//  Copyright © 2017 Alexander Li. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    
    
    @IBAction func refresh(_ sender: Any) {
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    var connected = false;
    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Peripheral.peripherals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PeripheralTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PeripheralTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PeripheralTableViewCell.")
        }
        
        let peripheral = Peripheral.peripherals[indexPath.row]
        cell.nameLabel.text = peripheral.name

        return cell
    }
    
    //MARK: NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("TABLE SEGUE")
        
    }
    
    //MARK: SELECTION
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: \(Peripheral.peripheralNames[indexPath.row])")
        Peripheral.chosenPeripheralIndex = indexPath.row
        Peripheral.peripheralChosen = true
        self.performSegue(withIdentifier: "backToController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
