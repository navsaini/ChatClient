//
//  ViewController.swift
//  ChatClient
//
//  Created by Nav Saini on 2/18/16.
//  Copyright © 2016 Saini. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "There was an error", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default) { (action) in
            // handle response here.
            })
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }

    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailTextField.text!, password:passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let chatNavigationController = storyboard.instantiateViewControllerWithIdentifier("ChatNavigationController") as! UINavigationController
                
                self.presentViewController(chatNavigationController, animated: true, completion: nil)
               
            } else {
                // The login failed. Check error to see why.
                print(error)
            }
        }
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                print(errorString)
                self.showErrorAlert()
            } else {
                // Hooray! Let them use the app now.
                print("sign up successful")
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.emailTextField.becomeFirstResponder()
            }
        }
    }
}




