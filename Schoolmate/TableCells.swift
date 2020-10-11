//
//  TableCells.swift
//  Schoolmate
//
//  Created by Daniel Nzioka on 9/23/20.
//

import Foundation
import UIKit

class AssignmentCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var assignmentText: UILabel!
    @IBOutlet weak var assignmentDetailText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}

class ReminderCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var reminderText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
