//
//  LogDetailViewController.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class LogDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var backButton: UIButton!;
    
    @IBOutlet weak var topContainerView: ContainerView!;
    @IBOutlet weak var titleTextField: UITextField!;
    @IBOutlet weak var modiferCaptionLabel: UILabel!;
    @IBOutlet weak var modifierValueLabel: UILabel!;
    @IBOutlet weak var totalTimeCaptionLabel: UILabel!;
    @IBOutlet weak var totalTimeValueLabel: UILabel!;
    @IBOutlet weak var realtimeCalculationCaptionLabel: UILabel!;
    @IBOutlet weak var realtimeCalculationValueLabel: UILabel!;
    @IBOutlet weak var startStopButton: UIButton!;
    
    @IBOutlet weak var bottomContainerView: ContainerView!;
    @IBOutlet weak var timeSegmentsLabel: UILabel!;
    @IBOutlet weak var tableView: UITableView!;
    
    
    // Variables
    var logModel:FreelanceLog = FreelanceLog(dataDictionary: [:]);
    var time:Double = 0.0;
    var value:Double = 20000.0;
    var timer:NSTimer? = nil;
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // * LOCALIZE *
        self.timeSegmentsLabel.text = "Time Segments";
        
        // Set Log Details
        print("Model Details: \(self.logModel)");
        self.titleTextField.text = self.logModel.name;
        
        // Set Text Field Border Colors

        // Input Attachment
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"));
        
        timer = NSTimer.scheduledTimerWithTimeInterval((1.0/60.0), target: self, selector: Selector("sayHello"), userInfo: nil, repeats: true)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =========================================================================
    // MARK: UITableViewDataSource
    // =========================================================================
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logModel.segments.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIndentifier = "Cell";
        let cell:TimeSegmentCell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! TimeSegmentCell;
        
        // Get Content
        let segmentModel:LogSegment = logModel.segments[indexPath.row]
        
        // Set Cell Data
        let calculatedTime:String = String(format:"%.2f hrs", (segmentModel.totalTime/3600.00));
        cell.logDateLabel.text = "\(AppManager.sharedInstance.localeDateString(date: segmentModel.creationDateTime, includeTime: false))";
        cell.logTimesLabel.text = "\(AppManager.sharedInstance.localeTimeString(date: segmentModel.startTime)) - \(AppManager.sharedInstance.localeTimeString(date: segmentModel.endTime))";
        cell.segmentTimeLabel.text = calculatedTime;
        
        // Handle X Button
        cell.xButton.tag = indexPath.row;
        cell.xButton.addTarget(self, action: "xButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside);
        
        // Handle Background Colors
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
    
    
    // =========================================================================
    // MARK: IBActions
    // =========================================================================
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    // Added Programmatically
    @IBAction func hideKeyboard() {
        self.titleTextField.resignFirstResponder();
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
    }
    
    @IBAction func xButtonPressed(sender: UIButton) {
        print("X button pressed for index: \(sender.tag)");
        
        // * LOCALIZE *
        let alert:UIAlertController = UIAlertController(
            title: "Delete Time Segment",
            message: "Are you sure you want to delete this time segment?",
            preferredStyle: UIAlertControllerStyle.Alert
        );
        
        let noAction:UIAlertAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil);
        alert.addAction(noAction);
        let yesAction:UIAlertAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: {(action:UIAlertAction) in
            self.deleteTimeSegment(sender.tag);
        });
        alert.addAction(yesAction)
        
        self.presentViewController(alert, animated: true, completion: nil);
    }
    
    
    // =========================================================================
    // MARK: Action Methods
    // =========================================================================

    func deleteTimeSegment(index:Int) {
        self.logModel.segments.removeAtIndex(index);
        AppManager.sharedInstance.saveLogs();
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic);
    }
    
    func sayHello() {
        var realtimeRate:Double = 0.0;
        self.time += (1.0/60.0);
        realtimeRate = self.value/(self.time/60.0);
        self.realtimeCalculationValueLabel.text = String(format:"$%.2f/hr", realtimeRate);
    }
    
}
