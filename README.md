#  SnapChatClone Notes

    This tutorial creates a snapchat clone.  The user logs in or signs up.
    The user can then either see the snap sent or send a snap to someone.
    The tutorial makes use of firebase.
    
## Setting up Firebase

    1. firebase.google.com - you will need to login to your account or create a new one.
    Then go to the console and add a new project - in this case, I added SnapChatClone.
    It gives you a project ID - snapchatclone-b915
    
    2. Select "Add Firebase to your iOS App" - you will need to add the Bundle ID from
    XCode (among other things which are necessary).  Click Register and download the
    resulting plist file.  Click continue.  Drag and drop (with Copy) the file into the
    project.  If you happen to have multiples of these, you may have one that's got a
    number as part of the name - e.g. GoogleService-info-2.plist.  You will need to rename
    the file to make it work properly (once it's in the project)
    
    3. Make sure the target membership is selected for the plist file.
    
### CocoaPods

    1. Nick uses the CocoaPods.org Mac App - cocoapods.org/app - there's a download for CocoaPods.app
    It's downloaded as CocoaPods.app-1.1.1.tar.bz2 so it will need to be unzipped.  Drag and drop into
    Applications.
    
    2. Close XCode while the PodFile is created.  Open the CocoaPods app.
    
    3. Select File->New PodFile from Xcode Project
    
    4. Select the SnapChatClone.xcodeproj file and click open
    
    5. You will get a basic podfile - cool
    
    4. Back in Safari, copy and paste the line pod 'Firebase/Core'
    and as the instructions indicate, add to the podfile (in CocoaPods.app).
    Click the Install button (again, in CocoaPods.app).
    
    If it’s successful, it will tell you to use the workspace file instead of the project file
    to open the Xcode project.
    
    5. The last thing you'll need from the Firebase website is the bit you add to the AppDelegate
    (the website is actually wrong)
    
    import Firebase
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 
         FIRApp.configure()
             
         return true
     }

## Back to SnapChatClone

    1. First view contains 2 text fields for an email and password as well as 2 buttons for login or
    sign-up.  The buttons and labels switch text depending on whether you logging in or signing up.
    It's not the best UI, but I'll go with it.  I added static text to a struct that I used to switch
    everything.
    
    The email should have a content type of "email" and select the keyboard type to also be email.
    The password can have a content type of password, and the "Secure Text Entry" should be
    selected.
    
    2. To authenticate the user (e.g. the top bottom is "sign up"), you need to install the
    Firebase Authentication pod - see https://firebase.google.com/docs/auth/ios/start
    This is under the Console, Documentation, Authentication (left menu panel), iOS -> Get Started.
    pod 'Firebase/Auth' has to be added to the podfile.  Finish by clicking Install in the CocoaPods
    app.
    
    3. In the Console for the SnapChatClone app, select the Authentication menu on the left
    panel, click on the Sign-In Methdo tab, and enable Email/Password.  From here you
    could also enable login using Facebook, Twitter, etc. 
    
    4. Back in XCode, add the import for FirebaseAuth
    
    5. Once the user is created, you can see the created user data from the console under
    Authentication/Users.  There is currently no checking in the app to prevent an
    attempt to create the same user (not the focus of this app).
    
    6. For praticality purposes, we set the default email and password to the user that
    was created - that way as we continue with the app, we don't need to re-type this in each
    time.  I chose to set this as the view is loaded...that way I can easily remove it..
    
    7.  Next up, add a Table View Controller to hold the list of snaps - embed THIS view
    controller in a Navigation Controller.  The segue from the AuthViewController to the this
    NavigationController is "Present Modally" since the user can't go back to the login screen
    once they've logged in (at least via a Back button).  This new tableView controller has a
    "logout" bar button item - this will take them back to the AuthViewController.
    
    8. When the user completes login, the Snaps TVC is shown (using performSegue withIdentifier).
    The segue also occurs if the user is signed up successfully.  From the Storyboard Segue
    Attributes Inspector, you can change the segue Transition and Presentation.  The default is
    that is is presented bottom to top.  Cross-dissolve seems better...and logout only dismisses
    the Snaps TVC - Nick doesn't log the user out using the Firebase Auth signout - I added this
    which seems to work fine.
    
    9. Next up, Add Snap - view with a camera and folder button in the bar button item area.
    ImageView holds the selected image.  There's a text field for a description and a "Next"
    button (TBD.).  Make sure the segue from the Add button to this new VC is "show" - otherwise,
    you won't get the usual left bar buttom item <  Also, the "Back" title on the Navigation Item
    on the Add Snap VC is set in the navigation item of the Snaps TVC - makes sense if you think
    about it.
    
    10. Layout for the image view - 20 left, 20, top, 20 right, with Aspect Ratio of 8:5 - control
    drag to the center of the image view and select Aspect Ratio.  You then edit this constraint
    to make it the ratio you want.  Nick used the Aspect Ratio on the Constraint dialog - instead of
    using the CTRL+Drag method.
    
    Text field is 20 left 20 right, and 20 vertical spacing to the image view.  Thw "Next" button is
    horizontal centered and 20 vertical spacing to the text field. Done.
    
    11. Firebase storage - we will be storing the selected images on Firebase.  First we need
    to add the POD for storage - as indicated at https://firebase.google.com/docs/storage/ios/start,
    you need to add to the podfile (and install) - note that each time you install, you need to set
    back some workspace settings (e.g. the simulator) in XCode.
    
        pod 'Firebase/Core'
        pod 'Firebase/Storage'
        
    Add import FirebaseStorage to the Add Snap VC.
    
    In the "Next" button handler, reference to where we're going to store the images - from the
    console for the app, click on storage - that shows the beginning stage where items will
    be stored - similar to a file system.
    
    12. The segue from the Add VC to the Contacts TVC is from the Add VC itself, not the Next button.
    
    13. Firebase database: see the documentation for Realtime Database, iOS, Get Started - indicates
    we need to add the pod 'Firebase/Database' to our podfile.

    Back in the Auth VC, inport FirebaseDatabase.  After the user is successfully created, we'll add
    that user to the database.  Note that the pattern for the API usage is like the Auth - e.g.
    FirebaseDatabase.database().reference().child("users") - "reference" gives the starting point
    whereas child("users") is the folder we're starting with:
    
```
        snapchatclone-b915
            users
                someUserID
                    email: "someUserEmail.com"
 ```

    14. Back in the Contacts TVC, we can retrieve these users from the Firebase database.
    We will use the "observe" with "child added" so we notice everytime something new is added -
    in this case, a child (e.g. user).
    
    15. The Firebase Database needs some additional data for each user - each snap sent to that user.  The
    snap data will contain the "from email", the image URL, image name (both needed for removal of the image),
    and the description (which will be stored as "message" since the term "description" is often used
    for other things).
    
    16. In the Add Image VC, we need to pass the image name, image URL, and description to the Contacts TVC.
    For the image name, use a UUID for the name - e.g. uuid.jpeg.  Initially the email data shown on the TVC
    was a [String] - to capture both the emails and the user's UUID, a User class was used instead (see the
    bottom of the Add TVC).  This could easily have been a struct inside of the Add TVC class.
    
    17. In the Snap TVC, the list of snaps for the logged in user is shown.  Instead of using another custom
    class to hold the snapshot data for each entry, the FIRDataSnapshot object type is used.
    
    18. The Snap VC is another "Show" segue from the Snaps TVC.  It shows the data for an individual snapshot.
    
    19. To download the image from the web (e.g. Firebase), we downloaded SDWebImage from CocoaPod.org.
    Note to self - there's a little clipboard next to the name of the pod that holds the line you
    need to add to the podfile - e.g. pod 'SDWebImage', '~> 4.1'
    
    With this pod, there are a number of methods available - they all begin with sd_
    e.g. imageView.sd_setImage(with: url)
    
    My repo was out of date (odd), so I first needed to run pod repo update from the terminal - then the install
    went through fine.
    
    
    
    
    
    
    
    
    
    
    
    
    
