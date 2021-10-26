//
//  FreelanceLog.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/7/15.
//  Copyright © 2015 Jaron Lowe. All rights reserved.
//

import UIKit


// =========================================================================
// MARK: Enums
// =========================================================================

enum LogType:String {
    case Hourly = "hourly"
    case FlatPrice = "flatprice"
}


class FreelanceLog: NSObject {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    var name:String = "";
    var creationDate:NSDate = NSDate();
    var type:LogType = LogType.FlatPrice;
    var segments:[LogSegment] = [];
    var flatPrice:Double = 0.0;
    var hourlyRate:Double = 0.0;
    var currencyCode:String = "USD";
    
    // Customized String Value
    // ---------------------------------------------------------------------------------
    override var description: String {
        return "\n{\n\tName: \(self.name),\n\tCreation Date: \(self.creationDate),\n\tType: \(self.type.rawValue),\n\tFlat Price: \(self.flatPrice),\n\tHourly Rate: \(self.hourlyRate),\n\tCurrency Code: \(self.currencyCode),\n\tSegments: \(self.segments)\n}";
    }
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    init(dataDictionary:[String:AnyObject]) {
        
        // Parse Legacy Data
        if let data:String = dataDictionary["Title"] as? String {self.name = data;}
        if let data:String = dataDictionary["StartDate"] as? String {self.creationDate = AppManager.sharedInstance.date(datetimeString: data);}
        if let data:Double = dataDictionary["Price"] as? Double {self.flatPrice = data;}
        
        // Parse New Data
        if let data:String = dataDictionary["Name"] as? String {self.name = data;}
        if let data:NSDate = dataDictionary["CreationDate"] as? NSDate {self.creationDate = data;}
        if let data:String = dataDictionary["Type"] as? String {
            if let type = LogType(rawValue: data) {self.type = type;}
        }
        if let data:[[String:AnyObject]] = dataDictionary["Segments"] as? [[String:AnyObject]] {
            self.segments = [];
            for segmentDict:[String:AnyObject] in data {
                let segment:LogSegment = LogSegment(dataDictionary: segmentDict);
                self.segments.append(segment);
            }
        }
        if let data:Double = dataDictionary["FlatPrice"] as? Double {self.flatPrice = data;}
        if let data:Double = dataDictionary["HourlyRate"] as? Double {self.hourlyRate = data;}
        if let data:String = dataDictionary["CurrencyCode"] as? String {self.currencyCode = data;}
        
        
    }
    
    init(name:String, creationDate:NSDate, type:LogType, flatPrice:Double, hourlyRate:Double) {
        self.name = name;
        self.creationDate = creationDate;
        self.type = type;
        self.flatPrice = flatPrice;
        self.hourlyRate = hourlyRate;
    }
    
    
    // =========================================================================
    // MARK: Helper Methods
    // =========================================================================
    
    func dictValue() -> [String:AnyObject] {
        var dict:[String:AnyObject] = [:]
        
        dict["Name"] = self.name;
        dict["CreationDate"] = self.creationDate;
        dict["Type"] = self.type.rawValue;
        var segmentDicts:[[String:AnyObject]] = [];
        for segment:LogSegment in self.segments { segmentDicts.append(segment.dictValue()); }
        dict["Segments"] = segmentDicts;
        dict["FlatPrice"] = self.flatPrice;
        dict["HourlyRate"] = self.hourlyRate;
        dict["CurrencyCode"] = self.currencyCode;
        
        return dict;
    }
    
    // Returns the total combined time of a log in seconds
    func calculatedTotalTime() -> Double {
        var totalTime:Double = 0.0;
        for timeSegment:LogSegment in self.segments { totalTime += timeSegment.totalTime; }
        return totalTime;
    }
    
    
}
