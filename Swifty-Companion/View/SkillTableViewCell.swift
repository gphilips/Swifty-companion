//
//  SkillTableViewCell.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 07/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var skill: Skill? {
        didSet {
            if let s = self.skill {
                nameLabel.text = s.name
                progressView.setProgress((s.level ?? 0) / 20, animated: true)
            }
        }
    }

}
