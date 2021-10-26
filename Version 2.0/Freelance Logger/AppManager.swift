//
//  AppManager.swift
//
//  Created by Jaron Lowe.
//  Copyright (c) 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit
import Foundation


// ============================================================================
// MARK: - Class Creation
// ============================================================================

class AppManager : NSObject {
    
    // ============================================================================
    // MARK: - Properties
    // ============================================================================
    
    // Singleton Property
    static let sharedInstance = AppManager();

    var logList:[FreelanceLog] = [];
    
    
    // ============================================================================
    // MARK: - Action Methods
    // ============================================================================
    
    // --------------------------------------------
    // UI Handling
    // --------------------------------------------
    
    // Fits an image to a specific size
    func fitImage(image:UIImage?, size:CGSize) -> UIImage? {
        if (image == nil) {return nil;}
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale);
        let imageRect:CGRect = CGRectMake(0.0, 0.0, size.width, size.height);
        image!.drawInRect(imageRect);
        let tempImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return tempImage;
    }

    
    // Date/Time Handling
    // ----------------------------------------------------
    
    // Returns an NSDate object from datetime string
    func date(datetimeString datetimeString:String) -> NSDate {
        
        let formatter:NSDateFormatter = NSDateFormatter();
        formatter.AMSymbol = "AM";
        formatter.PMSymbol = "PM";
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
        formatter.dateFormat = "MM/dd/yyyy";
        
        if let date = formatter.dateFromString(datetimeString) {return date;}
        else {return NSDate();}
    }
    
    // Returns a String in SQL datetime Format from NSDate
    func dateTimeString(date date:NSDate) -> String {
        var dateString:String = "";
        
        let formatter:NSDateFormatter = NSDateFormatter();
        formatter.AMSymbol = "AM";
        formatter.PMSymbol = "PM";
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0);
        
        dateString = formatter.stringFromDate(date);
        return dateString;
    }
    
    // Returns a Localized Date String
    func localeDateString(date date:NSDate, includeTime:Bool) -> String {
        var dateString:String = "";
        
        let locale:NSLocale = NSLocale.currentLocale();
        let formatter:NSDateFormatter = NSDateFormatter();
        formatter.AMSymbol = "AM";
        formatter.PMSymbol = "PM";
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle;
        if (includeTime == true) {formatter.timeStyle = NSDateFormatterStyle.ShortStyle;}
        else {formatter.timeStyle = NSDateFormatterStyle.NoStyle;}
        formatter.locale = locale;
        formatter.timeZone = NSTimeZone.localTimeZone();
        
        dateString = formatter.stringFromDate(date);
        
        return dateString;
    }
    
    // Returns a Localized Time String
    func localeTimeString(date date:NSDate) -> String {
        var timeString:String = "";
        
        let locale:NSLocale = NSLocale.currentLocale();
        let formatter:NSDateFormatter = NSDateFormatter();
        formatter.AMSymbol = "AM";
        formatter.PMSymbol = "PM";
        formatter.dateFormat = "hh:mm a";
        formatter.locale = locale;
        formatter.timeZone = NSTimeZone.localTimeZone();
        
        timeString = formatter.stringFromDate(date);
        return timeString;
    }
    
    
    // File Handling
    // ----------------------------------------------------
    
    // Returns a base path to the Document Directory.
    func documentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0];
    }
    
    // Returns a filepath to a file directly within the Document Directory.
    func pathFromDocumentDirectory(filename filename:String, fileExtension:String) -> String {
        var fullFilePath:String = filename + fileExtension;
        fullFilePath = (documentDirectory() as NSString).stringByAppendingPathComponent(fullFilePath);
        return fullFilePath;
    }
    
    // Loads a plist from the app bundle.
    func plistFromBundle(filename filename:String) -> NSDictionary? {
        if let bundle:String = NSBundle.mainBundle().pathForResource(filename, ofType: "plist") {
            let fileManager:NSFileManager = NSFileManager.defaultManager();
            if (fileManager.fileExistsAtPath(bundle)) {return NSDictionary(contentsOfFile: bundle);}
        }
        return nil;
    }
    
    // Loads a plist from the Document Directory, potentially falling back to the app bundle.
    func plistFromDocumentDirectory(filename filename:String, fallbackToBundle:Bool) -> NSDictionary? {
        let fullFileName:String = self.pathFromDocumentDirectory(filename: filename, fileExtension: ".plist");
        let fileManager:NSFileManager = NSFileManager.defaultManager();
        if (!fileManager.fileExistsAtPath(fullFileName)) {
            if (fallbackToBundle == true) {return plistFromBundle(filename: filename);}
            else {return nil;}
        }
        else {return NSDictionary(contentsOfFile: fullFileName);}
    }
    
    // Saves a plist to the Document Directory.
    func savePlist(dataDictionary dataDictionary:[String:AnyObject], fileName:String) {
        let path:String = self.pathFromDocumentDirectory(filename: fileName, fileExtension: ".plist");
        let objectDictionary:NSDictionary = dataDictionary;
        let result:Bool = objectDictionary.writeToFile(path, atomically: true);
        if (result == true) {print("Saving \(fileName) successful!");}
        else {print("Saving \(fileName) failed!");}
    }
    
    
    // ============================================================================
    // MARK: - App-Specific Methods
    // ============================================================================
    
    func getLogs() -> Bool {
        
        // Get Save Data
        if let saveData:[String: AnyObject] = AppManager.sharedInstance.plistFromDocumentDirectory(filename: "LogData", fallbackToBundle: true) as? [String:AnyObject] {
            if let logData:[[String:AnyObject]] = saveData["Logs"] as? [[String:AnyObject]] {
                
                // Parse Logs
                AppManager.sharedInstance.logList = [];
                for logDict:[String:AnyObject] in logData {
                    let log:FreelanceLog = FreelanceLog(dataDictionary: logDict);
                    AppManager.sharedInstance.logList.append(log);
                }
                return true;
            }
        }
        return false;
    }
    
    func saveLogs() {
        var root:[String:AnyObject] = [:];
        var logs:[[String:AnyObject]] = [];
        for log:FreelanceLog in self.logList { logs.append(log.dictValue()); }
        root["Logs"] = logs;
        
        self.savePlist(dataDictionary: root, fileName: "LogData");
    }
}
