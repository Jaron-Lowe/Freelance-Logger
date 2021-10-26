//
//  MyLogsViewController.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class MyLogsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerView: ContainerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addEntryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    let refresher:UIRefreshControl = UIRefreshControl();
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // * LOCALIZE *
        self.titleLabel.text = "My Logs";
        self.addEntryButton.setTitle("+ Add Entry", forState: UIControlState.Normal);
        
        // Setup refresh control
        self.refresher.addTarget(self, action: "refreshTable:", forControlEvents:UIControlEvents.ValueChanged);
        self.refresher.tintColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0);
        self.tableView.addSubview(self.refresher);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.getLogs();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =========================================================================
    // MARK: UITableViewDataSource
    // =========================================================================
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.sharedInstance.logList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIndentifier = "Cell";
        let cell:MyLogsCell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! MyLogsCell;
        
        // Get Content
        let logModel:FreelanceLog = AppManager.sharedInstance.logList[indexPath.row];
        
        // Set Cell Data
        cell.logNameLabel.text = logModel.name;
        cell.logDateLabel.text = "\(AppManager.sharedInstance.localeDateString(date: logModel.creationDate, includeTime: false))";
        cell.xButton.tag = indexPath.row;
        cell.xButton.addTarget(self, action: "xButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        if (indexPath.row%2 == 0) { cell.backgroundColor = UIColor(red: 0.84, green: 0.88, blue: 0.91, alpha: 0.9); }
        else { cell.backgroundColor = UIColor(red: 0.88, green: 0.92, blue: 0.91, alpha: 0.9); }
        
        return cell;
    }
    
    
    // =========================================================================
    // MARK: UITableViewDelegate
    // =========================================================================
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let controller:LogDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LogDetail") as? LogDetailViewController {
            controller.logModel = AppManager.sharedInstance.logList[indexPath.row];
            self.navigationController?.pushViewController(controller, animated: true);
        }
        
    }
    
    
    // =========================================================================
    // MARK: IBActions
    // =========================================================================
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func refreshTable(sender: UIRefreshControl) {
        self.getLogs();
    }
    
    @IBAction func xButtonPressed(sender: UIButton) {
        print("X button pressed for index: \(sender.tag)");
        
        // * LOCALIZE *
        let alert:UIAlertController = UIAlertController(
            title: "Delete Log",
            message: "Are you sure you want to delete this log?",
            preferredStyle: UIAlertControllerStyle.Alert
        );
        
        let noAction:UIAlertAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
        alert.addAction(noAction);
        let yesAction:UIAlertAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {(action:UIAlertAction) in
            self.deleteLog(sender.tag);
        });
        alert.addAction(yesAction)
        
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    
    // =========================================================================
    // MARK: Action Methods
    // =========================================================================
    
    func getLogs() {
        if (AppManager.sharedInstance.getLogs() == true) { self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic); }
        self.refresher.endRefreshing();
        
        print("Log Data: \(AppManager.sharedInstance.logList)");
    }
    
    func deleteLog(index:Int) {
        AppManager.sharedInstance.logList.removeAtIndex(index);
        AppManager.sharedInstance.saveLogs();
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic);
    }

    
}

