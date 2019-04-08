//
//  ProfileViewController.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var sections = [ModelDelegate]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].type {
            case .info:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoTableViewCell {
                    let sec = self.sections[indexPath.section] as! Infos
                    cell.userInfo = sec.infos[indexPath.row] as Info
                    return cell
                }
            case .skills:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "skillsCell", for: indexPath) as? SkillTableViewCell {
                    let sec = self.sections[indexPath.section] as! Skills
                    cell.skill = sec.skills[indexPath.row] as Skill
                    return cell
                }
            case .projects:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsCell", for: indexPath) as? ProjectTableViewCell {
                    let sec = self.sections[indexPath.section] as! Projects
                    cell.project = sec.projects[indexPath.section] as Project
                    return cell
                }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections[section].rowCount > 0 {
            let label : UILabel = UILabel()
            label.text = self.sections[section].sectionTitle
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 18.0)
            label.backgroundColor = UIColor.lightGray
            return label
        }
        else {
            return nil
        }
    }
}
