//
//  SnapsTableViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/27/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import FirebaseAuth

class SnapsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
         return 0
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnapCell", for: indexPath)

        // Configure the cell...

        return cell
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
