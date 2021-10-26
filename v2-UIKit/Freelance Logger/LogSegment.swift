//
//  LogSegment.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/9/15.
//  Copyright © 2011-Present Jaron Lowe. All rights reserved.
//

import UIKit


class LogSegment: NSObject {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    var startTime:NSDate = NSDate();
    var endTime:NSDate = NSDate();
    var totalTime:Double = 0.0;
    var creationDateTime:NSDate = NSDate();
    
    // Customized String Value
    // ---------------------------------------------------------------------------------
    override var description: String {
        return "{\n\tStart Time: \(self.startTime),\n\tEnd Time: \(self.endTime),\n\tTotal Time: \(self.totalTime),\n\tCreation DateTime: \(self.creationDateTime),\n}";
    }
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    init(dataDictionary:[String:AnyObject]) {
        
        // Parse Legacy Data
        if let data:Double = dataDictionary["StartTime"] as? Double {self.startTime = NSDate(timeIntervalSinceReferenceDate: data);}
        if let data:Double = dataDictionary["EndTime"] as? Double {self.endTime = NSDate(timeIntervalSinceReferenceDate: data);}
        if let data:Double = dataDictionary["TotalTime"] as? Double {self.totalTime = data;}
        if let data:String = dataDictionary["StartDate"] as? String {self.creationDateTime = AppManager.sharedInstance.date(datetimeString: data);}
        
        // Parse New Data
        if let data:NSDate = dataDictionary["StartTime"] as? NSDate {self.startTime = data;}
        if let data:NSDate = dataDictionary["EndTime"] as? NSDate {self.endTime = data;}
        if let data:NSDate = dataDictionary["StartDate"] as? NSDate {self.creationDateTime = data;}
        
        
    }
    
    
    // =========================================================================
    // MARK: Helper Methods
    // =========================================================================
    
    func dictValue() -> [String:AnyObject] {
        var dict:[String:AnyObject] = [:]
        
        dict["StartTime"] = self.startTime;
        dict["EndTime"] = self.endTime;
        dict["TotalTime"] = self.totalTime;
        dict["StartDate"] = self.creationDateTime;
        
        return dict;
    }
    
    
}
