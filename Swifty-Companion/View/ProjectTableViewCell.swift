//
//  ProjectTableViewCell.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 07/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    
    var project: Project? {
        didSet {
            if let p = self.project {
                nameLabel.text = p.name
                if p.validate == true && p.finalMark! > 0 {
                    markLabel.textColor = UIColor.green
                    markLabel.text = "\(String(describing: p.finalMark!)) %"
                }
                else if p.finalMark == 0 {
                    markLabel.textColor = UIColor.red
                    markLabel.text = "\(String(describing: p.finalMark!)) %"
                }
                else {
                    markLabel.textColor = UIColor.lightGray
                    markLabel.text = "In progress"
                }
            }
        }
    }

}
