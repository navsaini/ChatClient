//
//  ChatViewController.swift
//  ChatClient
//
//  Created by Nav Saini on 2/18/16.
//  Copyright © 2016 Saini. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [PFObject]?
    var count: Int = 0

    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("view has been loaded")
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Chat"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let query = PFQuery(className: "Message")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.messages = objects
                    print("this branch taken")
                    self.tableView.reloadData()
                    for message in self.messages! {
                        if message["text"] != nil {
                            print(message["text"])
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.messages != nil {
            return (self.messages?.count)!
        }
        else {
            print("returned 0")
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatCell
        let message = self.messages![indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSend(sender: AnyObject) {
        let message = PFObject(className: "Message")
        if message["text"] != nil && message["text"] !== "" && message["text"] !== "\n"{
            message["text"] = messageTextField.text
        }
        messageTextField.text = ""
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("message has been saved")
            } else {
                // There was a problem, check error.description
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
