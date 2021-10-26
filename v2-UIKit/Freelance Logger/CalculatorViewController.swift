//
//  CalculatorViewController.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!;
    @IBOutlet weak var backButton: UIButton!;
    @IBOutlet weak var containerView: ContainerView!;
    @IBOutlet weak var titleLabel: UILabel!;
    @IBOutlet weak var stackView: UIStackView!;
    @IBOutlet weak var contractPriceLabel: UILabel!;
    @IBOutlet weak var contractPriceTextField: UITextField!;
    @IBOutlet weak var hoursWorkedLabel: UILabel!;
    @IBOutlet weak var hoursWorkedTextField: UITextField!;
    @IBOutlet weak var avgHourlyWageLabel: UILabel!;
    
    // Variables
    var activeField:UITextField? = nil;
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        
        // * LOCALIZE *
        self.titleLabel.text = "Calculator"
        self.contractPriceLabel.text = "Contract Price:";
        self.hoursWorkedLabel.text = "Hours Worked:";
        
        // Set Text Field Border Colors
        self.contractPriceTextField.layer.borderColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).CGColor;
        self.contractPriceTextField.layer.borderWidth = 1.0;
        self.hoursWorkedTextField.layer.borderColor = UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0).CGColor;
        self.hoursWorkedTextField.layer.borderWidth = 1.0;
        
        // Input Attachment
        self.contractPriceTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged);
        self.hoursWorkedTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged);
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"));
        
        // Calculate Wage Value
        self.calculateWage();
        
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
        super.didReceiveMemoryWarning();
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
        if (textField == contractPriceTextField) {self.hoursWorkedTextField.becomeFirstResponder();}
        if (textField == hoursWorkedTextField) {self.contractPriceTextField.becomeFirstResponder();}
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
        self.contractPriceTextField.resignFirstResponder();
        self.hoursWorkedTextField.resignFirstResponder();
    }
    
    // Added Programmatically
    @IBAction func textFieldDidChange(sender: UITextField) {
        self.calculateWage();
    }
    
    
    // =========================================================================
    // MARK: Action Methods
    // =========================================================================
    
    // Validates inputs and calculates wage rate
    func calculateWage() {
        
        var calculatedRate:Double = 0.0;
        if let price = Double(self.contractPriceTextField.text!), hours = Double(self.hoursWorkedTextField.text!) {
            if (price != 0.0 && hours != 0.0) { calculatedRate = price/hours; }
        }
        
        // * LOCALIZE *
        self.avgHourlyWageLabel.text = String(format:"Avg. Hourly Wage:\n$%.2f", calculatedRate);
    }
    
    
}
