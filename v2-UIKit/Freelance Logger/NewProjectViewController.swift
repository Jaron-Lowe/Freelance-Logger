//
//  NewProjectViewController.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class NewProjectViewController: UIViewController {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!;
    @IBOutlet weak var backButton: UIButton!;
    @IBOutlet weak var containerView: ContainerView!;
    @IBOutlet weak var titleLabel: UILabel!;
    @IBOutlet weak var stackView: UIStackView!;
    @IBOutlet weak var projectNameLabel: UILabel!;
    @IBOutlet weak var projectNameTextField: UITextField!;
    @IBOutlet weak var projectTypeSegmenter: UISegmentedControl!;
    @IBOutlet weak var projectPriceLabel: UILabel!;
    @IBOutlet weak var projectPriceTextField: UITextField!;
    @IBOutlet weak var finishButton: UIButton!;

    // Variables
    var activeField:UITextField? = nil;
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // * LOCALIZE *
        self.titleLabel.text = "New Project";
        self.projectNameLabel.text = "Project Name:";
        self.projectNameTextField.placeholder = "Name";
        self.projectTypeSegmenter.setTitle("Hourly", forSegmentAtIndex: 0);
        self.projectTypeSegmenter.setTitle("Flat Price", forSegmentAtIndex: 1);
        self.projectPriceLabel.text = "Project Hourly Rate:";
        self.projectPriceTextField.placeholder = "$/hr";
        
        // Set Text Field Border Colors
        self.projectNameTextField.layer.borderColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).CGColor;
        self.projectNameTextField.layer.borderWidth = 1.0;
        self.projectPriceTextField.layer.borderColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).CGColor;
        self.projectPriceTextField.layer.borderWidth = 1.0;
        
        // Input Attachment
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"));
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil);
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ============================================================================
    // MARK: - Keyboard Handling
    // ============================================================================
    
    func keyboardWillShow(notification:NSNotification) {
        let info:NSDictionary = notification.userInfo!;
        let kbSize:CGSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size;
        
        scrollView.scrollEnabled = true;
        let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        var aRect:CGRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        if (activeField != nil) {
            if (!CGRectContainsPoint(aRect, activeField!.frame.origin)) {
                scrollView.scrollRectToVisible(activeField!.frame, animated: true);
            }
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        let contentInsets:UIEdgeInsets = UIEdgeInsetsZero;
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        scrollView.scrollEnabled = false;
    }
    
    
    // ============================================================================
    // MARK: - Text Field Handling
    // ============================================================================
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == projectNameTextField) {self.projectPriceTextField.becomeFirstResponder();}
        if (textField == projectPriceTextField) {self.addLog();}
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeField = textField;
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeField = nil;
    }
    
    
    // =========================================================================
    // MARK: IBActions
    // =========================================================================
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    // Added Programmatically
    @IBAction func hideKeyboard() {
        self.projectNameTextField.resignFirstResponder();
        self.projectPriceTextField.resignFirstResponder();
    }
    
    @IBAction func finishButtonPressed(sender: UIButton) {
        self.addLog();
    }
    
    @IBAction func typeSegmenterChanged(sender: UISegmentedControl) {
        
        // * LOCALIZE *
        if (sender.selectedSegmentIndex == 0) {
            // Hourly
            self.projectPriceLabel.text = "Project Hourly Rate:";
            self.projectPriceTextField.placeholder = "$/hr";
            
        } else if (sender.selectedSegmentIndex == 1) {
            // Flat Price
            self.projectPriceLabel.text = "Project Price:";
            self.projectPriceTextField.placeholder = "$";
            
        }
    }
    
    
    // =========================================================================
    // MARK: Action Methods
    // =========================================================================

    func addLog() {
        
        let newLog:FreelanceLog = FreelanceLog(dataDictionary: [:]);
        newLog.name = self.projectNameTextField.text!;
        newLog.creationDate = NSDate();
        
        // Validate Project Name
        if (self.projectNameTextField.text == "") {
            // * LOCALIZE *
            let alert:UIAlertController = UIAlertController(
                title: "Error",
                message: "The Project Name cannot be left blank.",
                preferredStyle: UIAlertControllerStyle.Alert
            );
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil);
            return;
        }
        
        // Validate price/rate and type
        if let price:Double = Double(self.projectPriceTextField.text!) {
            if (self.projectTypeSegmenter.selectedSegmentIndex == 0) {
                newLog.type = LogType.Hourly;
                newLog.hourlyRate = price;
            } else if (self.projectTypeSegmenter.selectedSegmentIndex == 1) {
                newLog.type = LogType.FlatPrice;
                newLog.flatPrice = price;
            }
            
        } else {

            // * LOCALIZE *
            let alert:UIAlertController = UIAlertController(
                title: "Error",
                message: "The Project Price and/or Hourly Rate must be a valid, non-zero number.",
                preferredStyle: UIAlertControllerStyle.Alert
            );
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil));
            self.presentViewController(alert, animated: true, completion: nil);
            return;
        }
        
        // Add new log and save
        AppManager.sharedInstance.logList.append(newLog);
        AppManager.sharedInstance.saveLogs();
        
        // Pop to previous controller
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    
}
