//
//  TimeSegmentCell.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/13/15.
//  Copyright © 2015 Jaron Lowe. All rights reserved.
//

import UIKit

class TimeSegmentCell: UITableViewCell {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var stackView: UIStackView!;
    @IBOutlet weak var logDateLabel: UILabel!;
    @IBOutlet weak var logTimesLabel: UILabel!;
    @IBOutlet weak var segmentTimeLabel: UILabel!;
    @IBOutlet weak var xButton: UIButton!;
    
    
    // Variables
    
    
    // =========================================================================
    // MARK: Initialization
    // =========================================================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
