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
    
    2. To authenticate the user (e.g. the top bottom is "sign up"), you need to install the
    Firebase Authentication pod - see https://firebase.google.com/docs/auth/ios/start
    This is under the Console, Documentation, Authentication (left menu panel), iOS -> Get Started.
    pod 'Firebase/Auth' has to be added to the podfile.  Finish by clicking Install in the CocoaPods
    app.
    
    3. Back in XCode, add the import for FirebaseAuth
    
    4. 
    
    
