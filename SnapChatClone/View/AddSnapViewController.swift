//
//  AddSnapViewController.swift
//  SnapChatClone
//
//  Created by Patty Harris on 8/28/17.
//  Copyright © 2017 Patty Harris. All rights reserved.
//

import UIKit
import FirebaseStorage

class AddSnapViewController: UIViewController,
                             UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
     
    var imagePicker : UIImagePickerController = UIImagePickerController()

    // Use a UUID for the image name...
    var imageName : String = "\(NSUUID().uuidString).jpeg"
    var imageURL : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    // This is called after the picker closes with the data picked.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The dictionary contains the data for what was picked.
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            snapImageView.image = chosenImage
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
    }

    @IBAction func cameraButtonDidTap(_ sender: Any) {
        
        // Again, this only works on a real phone...instead of crashing
        // I chose to make this work with an alert...
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.",
                                                         preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "OK", style: .default,
                                              handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func folderButtonDidTap(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        
        // Clicking the Next button allows the user to pick
        // who they want to send the image to.
        
        // First create a folder on the Firebase Storage
        let imageFolder = FIRStorage.storage().reference().child("images")
        
        if let image = snapImageView.image {
            
            // 0.1 is pretty low quality....easier for testing and uploading
            if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                
                // There are a number of ways to upload to Firebase (put methods) - the metadata
                // contains the download URL for the image - which will be passed along to the
                // contacts TVC.
                
                imageFolder.child(imageName).put(imageData, metadata: nil, completion: { (metadata, error) in

                    if let error = error {
                        print("Upload has failed: \(error.localizedDescription)")
                    }
                    else {
                        // Seque to TBD
                        print("Upload successful!")
                        
                        if let imageURL = metadata?.downloadURL()?.absoluteString {

                            self.imageURL = imageURL
                            
                            self.performSegue(withIdentifier: "snapToContactsSegue", sender: nil)
                        }
                        else {
                            print("Could not access image URL!")
                        }
                        
                    }

                })
            }
        }
        
    }
    
    // Pass along the image data to the Contacts TVC.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let contactsVC = segue.destination as? ContactsTableViewController {
            
            contactsVC.imageName = imageName
            contactsVC.imageURL = imageURL
            
            if let message = descriptionTextField.text {
                contactsVC.message = message
            }
        }
    }
}
