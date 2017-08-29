//
//  ContactsTableViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/28/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ContactsTableViewController: UITableViewController {

    // Data we need to pass to the Contacts TVC that will eventually be
    // stored in the Firebase Database for the "to" user.  Note that we're
    // using "message" instead of "description" since the latter is often used to
    // describe other things.
    
    var imageName : String = ""
    var imageURL : String = ""
    var message: String = ""

    // See
    // https://medium.cobeisfresh.com/dealing-with-complex-table-views-in-ios-and-keeping-your-sanity-ff5fee1fbb83
    // Great ariticle for working with complex tableViews...
    
    var users : [User] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load up the users - Firebase gives us back a snapshot of the database.
        FIRDatabase.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDictionary = snapshot.value as? NSDictionary {
                
                let user = User()
                
                if let email = userDictionary["email"] as? String {
                    
                    user.email = email
                    user.uuid = snapshot.key
                    
                    self.users.append(user)
                }
            }
            
            // Function gets called each time a user is added (in this case), so
            // reload the tableView.  Without this as well, no data will show...
            // See above didSet - much better way of handling the data.
            // self.tableView.reloadData()
        }

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = users[indexPath.row].email

        return cell
    }
    
    // Select a destinatin for the snap.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let user = users[indexPath.row]
        
        // Get the currently logged in user...
        if let currentUserEmail = FIRAuth.auth()?.currentUser?.email {
            
            let snapDictionary = ["from" : currentUserEmail,
                                  "imageName" : imageName,
                                  "imageURL" : imageURL,
                                  "message" : message]
            
            // Don't forget the ID for the new node - see childByAutoId....
            FIRDatabase.database().reference().child("users").child(user.uuid).child("snaps").childByAutoId().setValue(snapDictionary)
            
            // Pop back to the Snaps TVC - e.g. the root view controller.
            navigationController?.popToRootViewController(animated: true)

        }
        
        
        
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

// Class to capture the Firebase snapshot data needed for sending the snapshot.
class User {
    var email: String = ""
    var uuid: String = ""
}
