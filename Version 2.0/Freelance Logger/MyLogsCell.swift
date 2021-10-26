//
//  MyLogsCell.swift
//  Freelance Logger
//
//  Created by Jaron Lowe on 12/7/15.
//  Copyright © 2015 Jaron Lowe. All rights reserved.
//

import UIKit

class MyLogsCell: UITableViewCell {

    // =========================================================================
    // MARK: Properties
    // =========================================================================
    
    // IBOutlets
    @IBOutlet weak var stackView: UIStackView!;
    @IBOutlet weak var logNameLabel: UILabel!;
    @IBOutlet weak var logDateLabel: UILabel!;
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
