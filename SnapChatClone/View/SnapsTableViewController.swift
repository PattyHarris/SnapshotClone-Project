//
//  SnapsTableViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/27/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {

    var snaps : [FIRDataSnapshot] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // For the logged in user, show the snaps for that user.
        if let currentUserUID = FIRAuth.auth()?.currentUser?.uid {
            FIRDatabase.database().reference().child("users").child(currentUserUID).child("snaps").observe(.childAdded, with: { (snapshot) in
                
                // If you use the FIRDataSnapshot, you'd only need to do
                self.snaps.append(snapshot)
                
                // Update the tableView - not needed here with the array didSet
                // above
                // self.tableView.reloadData()
            })
            
            // We also want to know when a snap has been removed.
            FIRDatabase.database().reference().child("users").child(currentUserUID).child("snaps").observe(FIRDataEventType.childRemoved, with: { (snapshot) in
                
                // Find the snap that matches and remove it
                var index = 0;
                for snap in self.snaps {
                    if snap.key == snapshot.key {
                        
                        self.snaps.remove(at: index)
                    }
                    
                    index += 1
                }
                
                // Update the tableView - not needed here with the array didSet
                // above
                // self.tableView.reloadData()
            })
        }
        
    }

    // MARK: - Button handlers
    
    @IBAction func logoutButtonDidTap(_ sender: Any) {
        // Close this view controller.  This really doesn't "logout"
        // per se
        dismiss(animated: true, completion: nil)
        
        // I added the sign out here....
        let firebaseAuth = FIRAuth.auth()
        
        do {
            try firebaseAuth?.signOut()
            print("Sign out successful!")
        }
        catch let signOutError as NSError {
            print("Sign out failed: \(signOutError)")
        }
    }
    
    @IBAction func addButtonDidTap(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return snaps.count
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnapCell", for: indexPath)

        // Configure the cell...
        let snapshot = snaps[indexPath.row]

        if let snapDictionary = snapshot.value as? NSDictionary {
            
            if let email = snapDictionary["from"] as? String {
                cell.textLabel?.text = email
            }
        }
        
        return cell
    }
    
    // Show the Snap View Controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "snapsToSnapViewSegue", sender: snaps[indexPath.row])
    }


    // MARK: - Navigation

    // Give the snapshot data to the view snap VC.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let snapViewController = segue.destination as? SnapViewController {
            
            if let snapshot = sender as? FIRDataSnapshot {
                snapViewController.selectedSnap = snapshot
            }
        }
    }

}
