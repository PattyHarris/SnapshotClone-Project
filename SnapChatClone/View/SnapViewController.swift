//
//  SnapViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/30/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit

import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

import SDWebImage

class SnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var selectedSnap : FIRDataSnapshot?
    
    // Needed for removal.
    var snapshotKey : String?
    var imageName : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let snapshot = selectedSnap {

            if let userDictionary = snapshot.value as? NSDictionary {
                
                // We don't need the from (although I'd probably do that..)
                
                if let imageName = userDictionary["imageName"] as? String,
                        let imageURL = userDictionary["imageURL"] as? String,
                            let message = userDictionary["message"] as? String {
                    
                    if let url = URL(string: imageURL) {
                        imageView.sd_setImage(with: url, completed: nil)
                    }
                    
                    messageLabel.text = message

                    // Snap key and image name is used for removal.
                    self.snapshotKey = snapshot.key
                    self.imageName = imageName
                }
                
            }
        }
    }
    
    // The snap is removed as the view is dismissed.
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Remove the snap from storage as well as clean up images.
        // Get the current user ID
        
        if let currentUserUid = FIRAuth.auth()?.currentUser?.uid {
            
            // Remove from the database
            if let snapshotKey = snapshotKey {
                FIRDatabase.database().reference().child("users").child(currentUserUid).child("snaps").child(snapshotKey).removeValue()
            }
            
            // Remove from storage
            if let imageName = imageName {
                FIRStorage.storage().reference().child("images").child(imageName).delete(completion: { (error) in
                    if let error = error {
                        print("An error has occurred attempting to remove the image: \(error.localizedDescription)")
                    }
                })
            }
        }
        
    }

}
