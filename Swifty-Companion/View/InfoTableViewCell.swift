//
//  InfoTableViewCell.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 07/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var avatar: UIImageView!
    
    var userInfo: Info? {
        didSet {
            if let u = self.userInfo {
                if let firstName = u.firstName, let lastName = u.lastName {
                    nameLabel.text = "\(firstName) \(lastName)"
                }
                else {
                    nameLabel.text = ""
                }
                walletLabel.text = String(describing: u.wallet ?? 0) + " ₳"
                campusLabel.text = u.campus ?? ""
                gradeLabel.text = u.grade ?? ""
                pointLabel.text = String(describing: u.correctionPoint ?? 0)
                promoLabel.text = "Promo \(u.poolYear ?? "")"
                loginLabel.text = u.login ?? ""
                phoneLabel.text = u.phone ?? "0000000000"
                emailLabel.text = u.email ?? ""
                if let loc = u.location, loc != "null" {
                    availableLabel.text = "Available"
                    positionLabel.text = loc
                }
                else {
                    availableLabel.text = "Unavailable"
                    positionLabel.text = ""
                }
                
                if let level = u.level, let levelPercent = u.levelPercent {
                    levelLabel.text = "level \(Int(level)) - \(floor(levelPercent * 100))%"
                }
                else {
                    levelLabel.text = "level 0 - 0%"
                }
                progressBar.setProgress(u.level! / 100, animated: true)
                progressBar.transform = CGAffineTransform(scaleX: 1, y: 4)

                avatar.layer.borderWidth = 2
                avatar.layer.borderColor = UIColor.white.cgColor
                avatar.clipsToBounds = true
                avatar.image = u.image

            }
        }
    }
}
